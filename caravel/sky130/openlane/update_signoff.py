import os 
import shutil

openlane_folder = './'
signoff_folder = '../signoff'

# macro_folders = os.listdir(openlane_folder)
macro_folders = ['caravan_core']

# iterate over each macro folder 
for macro_folder in macro_folders:
    if os.path.isdir(macro_folder):       
        ## deleting old openlane-signoff
        openlane_signoff_folder = os.path.join(signoff_folder, macro_folder, 'openlane-signoff')
        for the_file in os.listdir(openlane_signoff_folder):
            file_path = os.path.join(openlane_signoff_folder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path): 
                    shutil.rmtree(file_path)
                print("Deleting ", file_path)
            except Exception as e:
                print(e)
                # os.remove(os.path.join(root, file))

        last_run_folder = os.path.join(openlane_folder, macro_folder, 'runs', macro_folder)
        files_in_last_run = os.listdir(last_run_folder)
        ## copying summary files
        for file in files_in_last_run:
            file_path = os.path.join(last_run_folder, file)
            if os.path.isfile(file_path):
                destination = os.path.join(signoff_folder, macro_folder, file)
                print("Copying ", file_path, " into ", destination)
                shutil.copyfile(file_path, destination)
        
        reports_folder = os.path.join(last_run_folder, 'reports')
        reports_folder_files = os.listdir(reports_folder)
        for file in reports_folder_files:
            file_path = os.path.join(reports_folder, file)
            if os.path.isfile(file_path):
                destination = os.path.join(signoff_folder, macro_folder, file)
                print("Copying ", file_path, " into ", destination)
                shutil.copyfile(file_path, destination)

        ## copying signoff reports
        signoff_reports_folder = os.path.join(last_run_folder, 'reports', 'signoff')
        signoff_reports_folder_files = os.listdir(signoff_reports_folder)
        for file in signoff_reports_folder_files:
            file_path = os.path.join(signoff_reports_folder, file)
            if os.path.isfile(file_path):
                destination = os.path.join(signoff_folder, macro_folder, 'openlane-signoff', file)
                print("Copying ", file_path, " into ", destination)
                shutil.copy(file_path, destination)
        
        ## copying spef and sdf 
        spef_folder = os.path.join(last_run_folder, 'results', 'routing', 'mca', 'spef')
        destination = os.path.join(signoff_folder, macro_folder, 'openlane-signoff', 'spef')
        print("Copying ", spef_folder, " into ", destination)
        shutil.copytree(spef_folder, destination)
        
        sdf_folder = os.path.join(last_run_folder, 'results', 'routing', 'mca', 'sdf')
        destination = os.path.join(signoff_folder, macro_folder, 'openlane-signoff', 'sdf')
        print("Copying ", sdf_folder, " into ", destination)
        shutil.copytree(sdf_folder, destination)
