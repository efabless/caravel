# remove_disconnect.awk: Recursively removes disconnected ports from a spice file

#   Copyright 2022 D. Mitch Bailey  cvc at shuharisystem dot com

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#   
#       http://www.apache.org/licenses/LICENSE-2.0
#   
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# port_lines: all the port lines for the current subckt
# instance_lines: all the lines for the current instance
# device_lines: all the lines for all instances in the current subckt

# Dictionaries
# port_order: maps 'port' to port_order for current subckt
# connections: maps 'subckt "&" port_order' to number of connections

BEGIN {
	# initialize autoincrement arrays
	delete port_lines[0]
	delete device_lines[0]
	delete instance_lines[0]
}

/^\+/ {
	# continuation line: either a port or an instance
	if ( continuation_type == "port" ) {
		ReadPorts(subckt, 2);
	} else {
		instance_lines[length(instance_lines)+1] = $0;
		# the parent is always the last field of the instance, 
		# update for each continuation line.
		parent = $NF;
	}
	next;
}

/^.subckt/ || /^.SUBCKT/ {
	# subckt definition; start reading ports
	continuation_type = "port";
	subckt = $2;
	port_count = 0;
	ReadPorts(subckt, 3);
	next;
}

/^[CcDdMmRrXx]/ {
	# instance definition; start reading instance
	if ( length(instance_lines) > 0 ) {
		# copy previous instance lines to device lines 
		# after removing disconnected ports
		SaveInstance(subckt, parent);
	}
	continuation_type = "device";
	instance_lines[length(instance_lines)+1] = $0;
	# the parent is always the last field of the instance
	parent = $NF;
	next;
}

/^.ends/ || /^.ENDS/ {
	# end of subckt; print out used ports and updated instances
	if ( length(instance_lines) > 0 ) {
		# copy previous instance lines to device lines
		# after removing disconnected ports
		SaveInstance(subckt, parent);
	}
	# save the current line
	current = $0;
	# print the port lines after removing disconnected ports
	port_count = 0;
	for (port_line_it = 1; port_line_it <= length(port_lines); port_line_it++ ) {
		# automatic parsing with $0 = ...
		$0 = port_lines[port_line_it];
		if ( port_line_it == 1 ) {
			RemoveDisconnectedPorts(subckt, 3);
		} else {
			RemoveDisconnectedPorts(subckt, 2);
		}
		# only print lines that have ports remaining
		if ( ! /^\+ *$/ ) {
			print $0;
		}
	}
	# print device lines
	for (device_line_it = 1; device_line_it <= length(device_lines); device_line_it++ ) {
		print device_lines[device_line_it];
	}
	print current;
	delete port_order;
	delete port_lines;
	delete port_lines[0];  # reinitialize array
	delete device_lines;
	delete device_lines[0];  # reinitialize array
	next;
}

 {
	# print any other lines: comments and spaces. 
	# does not preserve order of lines within a subckt.
	print $0;
}


function SaveInstance(subckt, parent) {
	# SaveInstance: copy instance_lines to device_lines after removing nets 
	#               when the corresponding parent port is disconnected
	# Inputs:
	#  subckt: the current subckt name
	#  parent: the parent subckt name for this instance
	# Modifies:
	#  connections: adds the number of connections to each of the current subckt ports
	#  device_lines: appends the modified instance_lines
	#  instance_lines: resets after processing
	net_number = 0;
	used_count = 0;
	# save the current line
	current = $0;
	verified_count = length(device_lines);
	for (instance_line_it = 1; instance_line_it <= length(instance_lines); instance_line_it++ ) {
		# automatic parsing with $0 = ...
		$0 = instance_lines[instance_line_it];
		# first field is either instance name or '+' so skip it
		for (net_it = 2; net_it <= NF; net_it++) {
			net_number += 1;
			connection_key = parent "&" net_number;
			if ( connection_key in connections && connections[connection_key] == 0 ) {
				# if the parent port is unused, removed it
				$net_it = "";
			} else if ( $net_it != parent ) {
				used_count += 1;
				if ( $net_it in port_order ) {
					# if this net is a port, count it
					connections[subckt "&" port_order[$net_it]] += 1;
				}
			}
		}
		## ignore one line instances that have all ports removed
		#if ( length(instance_lines) == 1 && used_count == 0 ) {
			#continue;
		#}
		# only keep lines that have nets remaining
		if ( ! /^\+ *$/ ) {
			device_lines[length(device_lines)+1] = $0;
		}
	}
	if ( used_count == 0 ) {
		# Remove instances that have all ports removed
		while ( length(device_lines) > verified_count ) {
			delete device_lines[length(device_lines)];
		}
	}
	delete instance_lines;
	delete instance_lines[0];  # reinitialize array
	# restore the current line
	$0 = current;
}


function ReadPorts(subckt, start) {
	# ReadPorts: sets port_order for each port and initializes connection count
	# Inputs:
	#  start: index of first port field on current line
	#  subckt: the current subckt name
	# Modifies:
	#  port_lines: saves current line
	#  port_count: increments for each port
	#  port_order: sets port order for each port
	#  connections: initializes connection count for each port in subckt
	port_lines[length(port_lines)+1] = $0;
	for (port_it = start; port_it <= NF; port_it++ ) {
		port_count += 1;
		port_order[$port_it] = port_count;
		connections[subckt "&" port_count] = 0;
	}
}


function RemoveDisconnectedPorts(subckt, start) {
	# RemoveDisconnectedPorts: removes disconnected ports from current line
	# Inputs:
	#  start: index of first port field on current line
	#  subckt: the current subckt name
	# Modifies:
	#  port_count: increments for each port
	#  current line: removes unused ports
	for ( port_it = start; port_it <= NF; port_it++ ) {
		port_count += 1;
		connection_key = subckt "&" port_count;
		if ( connection_key in connections && connections[connection_key] == 0 ) {
			# if the port is unused, removed it
			$port_it = "";
		}
	}
}
