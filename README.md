![Logo](PokeGuide2.jpeg)
<img src="PokeGuide2.png" alt="PokeGuide Logo" width="150" height="100">

# Pokémon Database Management Application

## Overview
This is a comprehensive Python application for managing a Pokémon database using MySQL, providing various functionalities for tracking Pokémon, battles, items, and more.

## Database Functions

### Pokémon Management
- `addNewPokemon()`: 
  - Allows adding a new Pokémon to the database
  - Collects detailed information including Pokémon number, name, stats, moves, and type
  - Inserts data into multiple tables: Owned_Pokemon, Moves, and Poke_Type
  - Handles database transactions with commit and rollback

- `readAboutPokemon()`:
  - Provides flexible search for Pokémon by name or type
  - Retrieves comprehensive Pokémon details including stats, type information
  - Displays results in a tabular format using tabulate library

- `releasePokemon()`:
  - Enables deleting a Pokémon from the database
  - Supports deletion by Pokémon name or number
  - Provides feedback on successful deletion or if no Pokémon is found

### Battle System
- `addNewBattle()`:
  - Supports adding both Gym and Normal battles
  - Tracks battle details like Pokémon used, outcome, date
  - Updates gym badges for won battles
  - Automatically updates Pokémon XP after battles

- `viewBattleData()`:
  - Provides flexible filtering for battle history
  - Can filter by battle type, outcome, date range, Pokémon
  - Displays battle information in a detailed table

- `updateXP()`:
  - Automatically manages Pokémon experience points
  - Increases XP based on battle outcomes
  - Levels up Pokémon when XP reaches certain thresholds

### Item and Inventory Management
- `viewItemsInBag()`:
  - Allows viewing different types of items (Pokéballs, Berries, Normal Items)
  - Displays item details like quantity, cost, effects

- `checkCuresForAilments()`:
  - Searches for items that can cure specific ailments
  - Checks both Berries and Normal Items
  - Provides details about potential cures

### Rival and Gym Tracking
- `listRivalTrainers()`:
  - Displays all registered rival trainers
  - Shows trainer numbers and names

- `editRivalTrainers()`:
  - Allows adding or deleting rival trainers
  - Supports modification by trainer number or name

- `viewGyms()`:
  - Shows detailed information about Pokémon gyms
  - Displays gym locations, badges, types, and leaders

### Move and Ailment Information
- `readMoves()`:
  - Provides comprehensive move information
  - Can filter moves by type or Pokémon
  - Shows move details like power, accuracy, category

- `readAilments()`:
  - Lists all ailments and their potential cures
  - Helps players understand status conditions and treatments

## Database Connection
- Uses PyMySQL for database connectivity
- Connects to a local MySQL database named 'PokeGuide'
- Implements error handling for database operations

## Usage
1. Ensure MySQL is installed and running
2. Create the 'PokeGuide' database with required tables
3. Update database connection parameters in the script
4. Run the script and navigate through menu options

## Dependencies
- Python 3.x
- PyMySQL
- tabulate

## Note
Requires a MySQL database setup with the specific schema used in this application.

