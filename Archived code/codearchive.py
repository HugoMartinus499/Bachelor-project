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
            
    def evaluate_candidate(self, candidate: "Candidate"):
        if candidate.success == True:
             

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
    return(Voter)

class Candidate(Agent):
    def __init__(self, unique_id, model, success: bool):
        super().__init__(unique_id, model)
        self.id = unique_id
        self.success = success       
        
def evaluate_candidate(self):
        min_difference = float('inf')
        chosen_candidate = None

        for candidate in self.model.candidates:
            # Calculate the weighted difference between voter and candidate attributes
            difference = sum(
                self.attributes[attr] * abs(self.attributes[attr] - getattr(candidate, attr))
                for attr, weight_attr in zip(
                    [
                        "government-intervention",
                        "government-control-of-economy",
                        "free-trade",
                        "protectionism",
                        "pro-choice",
                        "tax-increase-to-offset-debt-and-deficit",
                        "crime-punishment-level",
                        "military-hawkishness",
                        "non-military-interventions",
                        "affirmative-action",
                        "prayer-in-schools",
                        "market-solution-to-healthcare",
                        "moralistic-law",
                    ],
                    [
                        "government-intervention-weight",
                        "government-control-of-economy-weight",
                        "free-trade-weight",
                        "protectionism-weight",
                        "pro-choice-weight",
                        "tax-increase-to-offset-debt-and-deficit-weight",
                        "crime-punishment-level-weight",
                        "military-hawkishness-weight",
                        "non-military-interventions-weight",
                        "affirmative-action-weight",
                        "prayer-in-schools-weight",
                        "market-solution-to-healthcare-weight",
                        "moralistic-law-weight",
                    ],
                )
                if attr in self.attributes and weight_attr in self.attributes
            )

            if difference < min_difference:
                min_difference = difference
                chosen_candidate = candidate

        return chosen_candidate.unique_id  # Return the chosen candidate's unique ID
    
    

# Step 1: Apply Weighting System
def apply_weighting(df):
    df['weighted_votes'] = 1  # Each vote starts with 1
    df.loc[df['information_level'] > 50, 'weighted_votes'] += 1  # Extra vote for info > 50
    df.loc[df['information_level'] > 75, 'weighted_votes'] += 2  # Two more votes for info > 75
    return df

# Apply weighting to your dataset
weighted_voting_results = combined_voting_results.copy()
weighted_voting_results = apply_weighting(weighted_voting_results)

# Step 2: Calculate Final Votes by Weighted System
weighted_vote_counts = (
    weighted_voting_results.groupby(['sim', 'Vote'])
    .agg({'weighted_votes': 'sum'})
    .unstack(fill_value=0)
)

if isinstance(weighted_vote_counts.columns, pd.MultiIndex):
    weighted_vote_counts.columns = weighted_vote_counts.columns.droplevel(0)

weighted_vote_counts['weighted'] = 1  # Indicate weighted

# Calculate Final Votes by Unweighted System
unweighted_vote_counts = (
    combined_voting_results.groupby(['sim', 'Vote'])
    .size()
    .unstack(fill_value=0)
)

if isinstance(unweighted_vote_counts.columns, pd.MultiIndex):
    unweighted_vote_counts.columns = unweighted_vote_counts.columns.droplevel(0)

unweighted_vote_counts['weighted'] = 0  # Indicate unweighted

# Combine Weighted and Unweighted Data
comparison_df = pd.merge(
    weighted_vote_counts.reset_index(),
    unweighted_vote_counts.reset_index(),
    on=['sim'],
    suffixes=('_weighted', '_unweighted'),
    how='outer'
)

# Fill missing values
# comparison_df.fillna(0, inplace=True)

# Step 3: Prepare Data for Regression
comparison_df['vote_binary'] = np.where(
    comparison_df['Candidate_1_weighted'] > comparison_df['Candidate_0_weighted'], 1, 0
)

# Step 4: Fit GLM with Logistic Regression
formula = 'vote_binary ~ weighted'
model = glm(formula=formula, data=comparison_df, family=sm.families.Binomial())
result = model.fit()

# Print summary of the results
print(result.summary())

