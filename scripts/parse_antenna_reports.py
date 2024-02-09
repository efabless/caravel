import os

coor_ind = None
cell_ind = 0


block_name = "caravel"
log_file = open(f"calculated_vios_{block_name}.txt", "w")
for file in os.listdir(block_name):
    if file.startswith("ar_"):
        if file.endswith(".db"):
            db_file = os.path.join(block_name, file)
            met_layer = db_file.split('_')[1].split('.')[0]
            if 'met' in met_layer:
                with open(db_file) as f:
                    for num, line in enumerate(f, 1):
                        if line.startswith('CELL='):
                            cell = line.split(' ')[0].split('=')[1]
                        if line.startswith('fgate'):
                            g_area = float(line.split(' ')[1].split('=')[1])
                        if line.startswith(met_layer.capitalize()):
                            per = float(line.split(' ')[2].split('=')[1])
                            coor_ind = 0
                            cell_ind = num
                        if line.startswith('p 1') and num > cell_ind:
                            coor_ind = num + 1
                        if num == coor_ind:
                            coor = line
                        if line.startswith('Ant_diode'):

                            ant_area = float(line.split(' ')[1].split('=')[1])
                            if ant_area != 0:
                                ratio = (per / g_area) - 400*ant_area - 2200
                                # if round(ratio/400,2) > 10:
                                log_file.write(f"antenna violation on {met_layer} in cell {cell}: {round(ratio,2)} || with diffusion area: {round(ant_area,2)} || ratio/400 = {round(ratio/400,2)} || coordinates = {coor}")
                            else:
                                ratio = per / g_area
                                # if round(ratio/400,2) > 10:
                                log_file.write(f"antenna violation on {met_layer} in cell {cell}: {round(ratio,2)} || without diffusion || ratio/400 = {round(ratio/400,2)} || coordinates = {coor}")

