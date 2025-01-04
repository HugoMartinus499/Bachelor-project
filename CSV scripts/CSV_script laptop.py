import os

titles = ["RANDOM STATE", "GLOBALS", "TURTLES", "PATCHES", "LINKS", "PLOTS", "EXTENSIONS"]

base_dir = "C:/Users/hugov/UNI/semester05/Bachelor-project/Data/"
txt_dir = os.path.join(base_dir, "TXT_world_files")
csv_dir = os.path.join(base_dir, "CSV")

# Ensure the CSV directory exists
os.makedirs(csv_dir, exist_ok=True)

# Define the ranges for the file names
range_1 = range(1, 21)  # 1 to 20
range_2 = [500, 750] #Number of people in simulation

for i in range_1:
    for j in range_2:
        file_name = f"Sim_{i}_{j}.txt"
        file_path = os.path.join(txt_dir, file_name)
            
        if not os.path.isfile(file_path):
            print(f"File not found: {file_path}")
            continue
            
        with open(file_path, 'r') as file:
            to_file = None
                
            for line in file:
                new_file = False
                for t in titles:
                    if t in line:
                        csv_file_name = f"{t}_{i}_{j}.csv"
                        csv_file_path = os.path.join(csv_dir, csv_file_name)
                        to_file = open(csv_file_path, 'w')
                        new_file = True
                        break  # Assuming only one title per line

                if not new_file and to_file is not None:
                    to_file.write(line)
            
        if to_file is not None:
            to_file.close()
