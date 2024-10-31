import os
import pandas as pd
from mesa import Model, Agent
from mesa.time import StagedActivation
from mesa.space import MultiGrid
from mesa.datacollection import DataCollector
from typing import List
import random

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
print(turtles_data.get("Turtles1_500"))

# Define the Voter class
class Voter(Agent):
    def __init__(self, unique_id, model, attributes):
        super().__init__(unique_id, model)
        self.id = unique_id
        # Initialize attributes from the DataFrame
        for key, value in attributes.items():
            setattr(self, key, value)

# Create a model function to initialize Voter agents from the DataFrame
def create_voters(model, data):
    for index, row in turtles_data.iterrows():
        # Use the 'who' column as the unique ID
        unique_id = row['who']
        # Extract relevant columns
        attributes = row.iloc[13:].to_dict()  # Columns 14 and 18-43 (0-based indexing)
        
        # Initialize and add Voter agent to the model
        voter = Voter(unique_id, model, attributes)
        model.schedule.add(voter)

class Candidate(Agent):
    def __init__(self, unique_id, model, success: bool):
        super().__init__(unique_id, model)
        self.id = unique_id
        self.success = success       