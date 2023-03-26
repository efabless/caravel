import os

# Set the directory path
directory_path = "./../lef/"

# Loop through all files in the directory
for filename in os.listdir(directory_path):
    # Check if the file is a lef file
    if filename.endswith(".lef"):
        # Open the file for reading and editing
        with open(os.path.join(directory_path, filename), "r+") as f:
            lines = f.readlines()
        print("Processing the lef file: ", os.path.join(directory_path, filename))

        # define the lines to search for and the lines to insert
        input_lines = ["PIN", "DIRECTION INPUT", "USE SIGNAL", "ANTENNAGATEAREA"]
        input_insert = "    ANTENNAGATEAREA 0.196500 ;\n"

        output_lines = ["PIN", "DIRECTION OUTPUT", "USE SIGNAL", "ANTENNADIFFAREA"]
        output_insert = "    ANTENNADIFFAREA 0.340600 ;\n"

        # iterate through the lines, searching for the lines to insert after
        for i in range(len(lines)):
            if input_lines[0] in lines[i]:
                if input_lines[1] in lines[i+1]:
                    if input_lines[2] in lines[i+2]:
                        if input_lines[3] not in lines[i+3]:
                            lines.insert(i+3, input_insert)
            if output_lines[0] in lines[i]:
                if output_lines[1] in lines[i+1]:
                    if output_lines[2] in lines[i+2]:
                        if output_lines[3] not in lines[i+3]:
                            lines.insert(i+3, output_insert)

        # write the modified contents back to the file
        with open(os.path.join(directory_path, filename), "w") as f:
            f.writelines(lines)