import os
import glob
import re

rst_dir_path = '../docs/mgmt_soc/'

# Get a list of all the .rst files in the directory, except for index.rst
file_list = [file_path for file_path in glob.glob(os.path.join(rst_dir_path, '*.rst')) if os.path.basename(file_path) != 'index.rst']

# Sort the file list in alphabetical order
file_list.sort()

# Concatenate the files into a single file
with open(os.path.join(rst_dir_path, 'mgmt_soc_regs.rst'), 'w') as output_file:
    for file_path in file_list:
        with open(file_path, 'r') as input_file:
            output_file.write(input_file.read())


# Open the file in read mode
with open('../docs/mgmt_soc/mgmt_soc_regs.rst', 'r') as file:
    contents = file.read()

    # Replace all ^ to - (subheading 2 to subheading 3)
    modified_contents_1 = contents.replace('^', '.')

    # Replace all - to ^ (subheading to subheading 2)
    pattern = r'^.*\n-+\n\n'
    modified_contents_2 = re.sub(pattern, lambda match: match.group(0).replace('-', '^'), modified_contents_1, flags=re.MULTILINE)

    # Replace all = to - (heading to subheading )
    pattern = r'^.*\n=+\n\n'
    modified_contents_3 = re.sub(pattern, lambda match: match.group(0).replace('=', '-'), modified_contents_2, flags=re.MULTILINE)
    

# Write the content of the modified file in source dir 
with open('../docs/source/mgmt_soc.rst', 'w') as file:
    file.write(modified_contents_3)

# Prepend a heading to the rst file 
with open('../docs/source/mgmt_soc.rst', 'r') as file:
    contents = file.read()
new_contents = 'Management SoC - Litex\n' + '======================\n\n' + contents
with open('../docs/source/mgmt_soc.rst', 'w') as file:
    file.write(new_contents)


# File which has mgmt soc introduction summary 
#with open('../docs/mgmt_soc/mgmt_soc_intro.rst', 'r') as file1:
#    contents1 = file1.read()

# File which contain the mgmt soc registers 
#with open('../docs/mgmt_soc/mgmt_soc_regs.rst', 'r') as file2:
#    contents2 = file2.read()

#concatenated_contents = contents1 + contents2

#with open('../docs/source/mgmt_soc.rst', 'w') as new_file:

    # Write the concatenated string to the new file
#    new_file.write(concatenated_contents)



