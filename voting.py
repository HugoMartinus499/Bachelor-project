import os
import pandas as pd

base_dir = "C:/Users/hugov/Github/Bachelor-project/Data/CSV"

# Define the ranges for the file names
range_1 = range(1, 21)
range_2 = [500, 750]

# Dictionary to store the data frames
turtles_data = {}

# Loop over the ranges and read the files dynamically
for i in range_1:
    for j in range_2:
        # Construct the file name
        file_name = f"TURTLES_{i}_{j}.csv"
        file_path = os.path.join(base_dir, file_name)
            
        # Read the CSV file and store it in the dictionary
        if os.path.exists(file_path):
            data_name = f"Turtles{i}_{j}"
            turtles_data[data_name] = pd.read_csv(file_path)
        else:
            print(f"File not found: {file_path}")

# Example access to a specific data frame
print(turtles_data.get("Turtles1_16_80"))
