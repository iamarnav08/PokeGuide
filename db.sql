-- Create database
CREATE DATABASE PokeGuide2;
USE PokeGuide2;

-- Create tables based on the schema

-- Ailment_Type
CREATE TABLE Ailment_Type (
    Ail_Name VARCHAR(50) PRIMARY KEY,
    Duration INT,
    Security_Level INT
);

-- Cure
CREATE TABLE Cure (
    Cure VARCHAR(50),
    Ail_Name VARCHAR(50),
    FOREIGN KEY (Ail_Name) REFERENCES Ailment_Type(Ail_Name)
);

-- Owned_Pokemon
CREATE TABLE Owned_Pokemon (
    Poke_Number INT PRIMARY KEY,
    Poke_Name VARCHAR(50),
    Height FLOAT,
    Weight FLOAT,
    Type VARCHAR(50),
    Category VARCHAR(50),
    XP INT,
    Gender VARCHAR(10),
    HP INT,
    Level INT,
    Special_Attack INT,
    Attack INT,
    Defence INT,
    Special_Defence INT,
    Speed INT
);
CREATE INDEX idx_poke_name ON Owned_Pokemon(Poke_Name);

-- Poke_Type
CREATE TABLE Poke_Type (
    Pokemon_Number INT,
    Type VARCHAR(50),
    Weak_Against VARCHAR(50),
    Immune_To VARCHAR(50),
    Strong_Against VARCHAR(50),
    PRIMARY KEY (Pokemon_Number, Type),
    FOREIGN KEY (Pokemon_Number) REFERENCES Owned_Pokemon(Poke_Number)
);

-- Moves
CREATE TABLE Moves (
    Move_Name VARCHAR(50),
    Type VARCHAR(50),
    Category VARCHAR(50),
    Power INT,
    Accuracy FLOAT,
    Contact BOOLEAN,
    PP INT,
    Pokemon_Number INT,
    PRIMARY KEY (Move_Name, Pokemon_Number),
    FOREIGN KEY (Pokemon_Number) REFERENCES Owned_Pokemon(Poke_Number)
);

-- Move_Type
CREATE TABLE Move_Type (
    Move_Name VARCHAR(50),
    Poke_Name VARCHAR(50),
    PRIMARY KEY (Move_Name, Poke_Name),
    FOREIGN KEY (Move_Name) REFERENCES Moves(Move_Name),
    FOREIGN KEY (Poke_Name) REFERENCES Owned_Pokemon(Poke_Name)
);

-- Battle
CREATE TABLE Battle (
    Battle_Number INT PRIMARY KEY,
    Battle_Type VARCHAR(50),
    Pokemon_Used INT,
    Date DATE,
    Outcome VARCHAR(50),
    FOREIGN KEY (Pokemon_Used) REFERENCES Owned_Pokemon(Poke_Number)
);

-- Normal_Battle
CREATE TABLE Normal_Battle (
    Battle_Number INT PRIMARY KEY,
    Location VARCHAR(50),
    Rival_ID INT,
    FOREIGN KEY (Battle_Number) REFERENCES Battle(Battle_Number)
);

-- Gym_Battle
CREATE TABLE Gym_Battle (
    Battle_Number INT PRIMARY KEY,
    Gym VARCHAR(50),
    Gym_Leader VARCHAR(50),
    FOREIGN KEY (Battle_Number) REFERENCES Battle(Battle_Number)
);

-- Bag_Items
CREATE TABLE Bag_Items (
    Item_Number INT PRIMARY KEY,
    Pokeball_Type VARCHAR(50),
    Item_Name VARCHAR(50),
    Berry_Name VARCHAR(50)
);

-- Pokeball
CREATE TABLE Pokeball (
    Item_Number INT,
    Count INT,
    Catch_Rate FLOAT,
    Cost INT,
    Type VARCHAR(50),
    PRIMARY KEY (Item_Number, Type)
);

-- Berry
CREATE TABLE Berry (
    Item_Number INT,
    Count INT,
    Effect VARCHAR(255),
    Found_At VARCHAR(50),
    Berry_Name VARCHAR(50),
    PRIMARY KEY (Item_Number, Berry_Name)
);
CREATE INDEX idx_berry_name ON Berry(Berry_Name);

-- Normal_Item
CREATE TABLE Normal_Item (
    Item_Number INT,
    Item_Name VARCHAR(50),
    Effect VARCHAR(255),
    Cost INT,
    Count INT,
    PRIMARY KEY (Item_Number, Item_Name)
);
CREATE INDEX idx_item_name ON Normal_Item(Item_Name);

-- Rival_Trainer
CREATE TABLE Rival_Trainer (
    Trainer_No INT PRIMARY KEY,
    Name VARCHAR(50)
);



-- Ailment_and_Cure
CREATE TABLE Ailment_and_Cure (
    Berry_Name VARCHAR(50),
    Item_Name VARCHAR(50),
    Ail_Name VARCHAR(50),
    FOREIGN KEY (Ail_Name) REFERENCES Ailment_Type(Ail_Name),
    FOREIGN KEY (Berry_Name) REFERENCES Berry(Berry_Name),
    FOREIGN KEY (Item_Name) REFERENCES Normal_Item(Item_Name)
);


-- Pokemon_Gym
CREATE TABLE Pokemon_Gym (
    Location VARCHAR(50) PRIMARY KEY,
    Badge_Won BOOLEAN,
    Gym_Badge VARCHAR(50),
    Gym_Type VARCHAR(50),
    Gym_Leader VARCHAR(50),
    Previous_Gym VARCHAR(50),
    Next_Gym VARCHAR(50)
);



-- Battling_Gym_Leader
CREATE TABLE Battling_Gym_Leader (
    Battle_Number INT,
    Pokemon_Number INT,
    Location VARCHAR(50),
    -- PRIMARY KEY (Battle_Number, Pokemon_Number),
    FOREIGN KEY (Battle_Number) REFERENCES Gym_Battle(Battle_Number),
    FOREIGN KEY (Pokemon_Number) REFERENCES Owned_Pokemon(Poke_Number)
);

-- Battling_Rival_Trainer
CREATE TABLE Battling_Rival_Trainer (
    Battle_Number INT,
    Pokemon_Number INT,
    Trainer_No INT,
    PRIMARY KEY (Battle_Number, Pokemon_Number),
    FOREIGN KEY (Battle_Number) REFERENCES Normal_Battle(Battle_Number),
    FOREIGN KEY (Pokemon_Number) REFERENCES Owned_Pokemon(Poke_Number),
    FOREIGN KEY (Trainer_No) REFERENCES Rival_Trainer(Trainer_No)
);


-- Populating the tables

-- Ailments
INSERT INTO Ailment_Type (Ail_Name, Duration, Security_Level)
VALUES
('Poison', 5, 2),
('Paralysis', 3, 3),
('Burn', 5, 2),
('Sleep', 3, 4),
('Freeze', 3, 5),
('Confusion', 3, 3),
('Flinching', 1, 1),
('Fainted', 0, 0);


-- Cures for ailments
INSERT INTO Cure (Cure, Ail_Name)
VALUES
('Antidote', 'Poison'),
('Paralyze Heal', 'Paralysis'),
('Burn Heal', 'Burn'),
('Awakening', 'Sleep'),
('Ice Heal', 'Freeze'),
('Full Restore', 'Confusion'),
('Full Heal', 'Flinching'),
('Revive', 'Fainted');

-- Pokéball Types
INSERT INTO Pokeball (Item_Number, Count, Catch_Rate, Cost, Type)
VALUES
(1, 50, 1.0, 200, 'Pokéball'),
(2, 30, 1.5, 600, 'Great Ball'),
(3, 20, 2.0, 1200, 'Ultra Ball'),
(4, 10, 3.0, 3000, 'Master Ball'),
(5, 40, 1.2, 300, 'Heal Ball'),
(6, 40, 1.0, 400, 'Premier Ball'),
(7, 50, 1.0, 150, 'Safari Ball');

-- Berry Types
INSERT INTO Berry (Item_Number, Count, Effect, Found_At, Berry_Name)
VALUES
(1, 10, 'Heals 10 HP', 'Route 1', 'Oran Berry'),
(2, 10, 'Restores PP for a move', 'Route 10', 'Leppa Berry'),
(3, 10, 'Heals paralysis', 'Route 3', 'Cheri Berry'),
(4, 10, 'Heals burn', 'Route 5', 'Chesto Berry'),
(5, 10, 'Heals poison', 'Route 12', 'Pecha Berry'),
(6, 10, 'Heals sleep', 'Route 8', 'Aspear Berry'),
(7, 10, 'Heals freeze', 'Route 6', 'Iapapa Berry'),
(8, 10, 'Cures confusion', 'Route 11', 'Tanga Berry');

-- Normal Items
INSERT INTO Normal_Item (Item_Number, Item_Name, Effect, Cost, Count)
VALUES
(1, 'Potion', 'Heals 20 HP', 200, 50),
(2, 'Super Potion', 'Heals 50 HP', 700, 30),
(3, 'Hyper Potion', 'Heals 120 HP', 1200, 20),
(4, 'Max Potion', 'Fully heals HP', 2500, 10),
(5, 'Revive', 'Revives fainted Pokémon', 1500, 10),
(6, 'HP Up', 'Increases HP stat', 2000, 5),
(7, 'Protein', 'Increases Attack stat', 2500, 5),
(8, 'Iron', 'Increases Defense stat', 2500, 5),
(9, 'Antidote', 'Heals poison', 100, 20),
(10, 'Paralyze Heal', 'Heals paralysis', 100, 20),
(11, 'Awakening', 'Heals sleep', 100, 20),
(12, 'Burn Heal', 'Heals burn', 100, 20),
(13, 'Ice Heal', 'Heals freeze', 100, 20),
(14, 'Full Restore', 'Fully heals HP and cures status', 3000, 10),
(15, 'Full Heal', 'Cures flinching', 200, 20);


-- Gym Locations and Details
INSERT INTO Pokemon_Gym (Location, Badge_Won, Gym_Badge, Gym_Type, Gym_Leader, Previous_Gym, Next_Gym)
VALUES
('Pewter City', TRUE, 'Boulder Badge', 'Rock', 'Brock', NULL, 'Cerulean City'),
('Cerulean City', TRUE, 'Cascade Badge', 'Water', 'Misty', 'Pewter City', 'Vermilion City'),
('Vermilion City', TRUE, 'Thunder Badge', 'Electric', 'Lt. Surge', 'Cerulean City', 'Celadon City'),
('Celadon City', TRUE, 'Rainbow Badge', 'Grass', 'Erika', 'Vermilion City', 'Fuchsia City'),
('Fuchsia City', TRUE, 'Soul Badge', 'Poison', 'Koga', 'Celadon City', 'Saffron City'),
('Saffron City', FALSE, 'Marsh Badge', 'Psychic', 'Sabrina', 'Fuchsia City', 'Cinnabar Island'),
('Cinnabar Island', FALSE, 'Volcano Badge', 'Fire', 'Blaine', 'Saffron City', 'Viridian City'),
('Viridian City', FALSE, 'Earth Badge', 'Ground', 'Giovanni', 'Cinnabar Island', NULL);

-- Owned Pokemon
INSERT INTO Owned_Pokemon (
    Poke_Number, Poke_Name, Height, Weight, Type, Category, XP, Gender, HP, Level, Special_Attack, Attack, Defence, Special_Defence, Speed
)
VALUES
-- Grass/Poison Pokémon
(1, 'Bulbasaur', 0.7, 6.9, 'Grass/Poison', 'Seed', 100, 'Male', 45, 5, 49, 49, 49, 65, 45),
(2, 'Ivysaur', 1.0, 13.0, 'Grass/Poison', 'Seed', 200, 'Female', 60, 16, 63, 62, 63, 80, 60),
(3, 'Venusaur', 2.0, 100.0, 'Grass/Poison', 'Seed', 300, 'Male', 80, 32, 122, 82, 83, 100, 80),

-- Fire Pokémon
(4, 'Charmander', 0.6, 8.5, 'Fire', 'Lizard', 100, 'Female', 39, 5, 52, 52, 43, 50, 65),
(5, 'Charmeleon', 1.1, 19.0, 'Fire', 'Flame', 200, 'Male', 58, 16, 64, 64, 58, 65, 80),
(6, 'Charizard', 1.7, 90.5, 'Fire/Flying', 'Flame', 300, 'Female', 78, 36, 109, 84, 78, 85, 100),

-- Water Pokémon
(7, 'Squirtle', 0.5, 9.0, 'Water', 'Tiny Turtle', 100, 'Male', 44, 5, 50, 48, 65, 64, 43),
(8, 'Wartortle', 1.0, 22.5, 'Water', 'Turtle', 200, 'Female', 59, 16, 65, 63, 80, 80, 58),
(9, 'Blastoise', 1.6, 85.5, 'Water', 'Shellfish', 300, 'Male', 79, 36, 85, 83, 100, 105, 78),

-- Electric Pokémon
(25, 'Pikachu', 0.4, 6.0, 'Electric', 'Mouse', 112, 'Male', 35, 10, 50, 55, 40, 50, 90),
(26, 'Raichu', 0.8, 30.0, 'Electric', 'Mouse', 218, 'Female', 60, 26, 90, 85, 55, 80, 110),

-- Bug Pokémon
(10, 'Caterpie', 0.3, 2.9, 'Bug', 'Worm', 39, 'Female', 45, 3, 20, 30, 35, 20, 45),
(12, 'Butterfree', 1.1, 32.0, 'Bug/Flying', 'Butterfly', 178, 'Male', 60, 10, 90, 45, 50, 80, 70),
(13, 'Weedle', 0.3, 3.2, 'Bug/Poison', 'Hairy Bug', 39, 'Male', 40, 3, 20, 35, 30, 20, 50),
(15, 'Beedrill', 1.0, 29.5, 'Bug/Poison', 'Poison Bee', 178, 'Female', 65, 10, 45, 90, 40, 80, 75),

-- Normal Pokémon
(16, 'Pidgey', 0.3, 1.8, 'Normal/Flying', 'Tiny Bird', 50, 'Male', 40, 5, 35, 45, 40, 35, 56),
(18, 'Pidgeot', 1.5, 39.5, 'Normal/Flying', 'Bird', 216, 'Female', 83, 36, 70, 80, 75, 70, 101),
(19, 'Rattata', 0.3, 3.5, 'Normal', 'Mouse', 51, 'Male', 30, 3, 25, 56, 35, 25, 72),
(20, 'Raticate', 0.7, 18.5, 'Normal', 'Mouse', 145, 'Female', 55, 20, 50, 81, 60, 50, 97),

-- Fighting Pokémon
(56, 'Mankey', 0.5, 28.0, 'Fighting', 'Pig Monkey', 61, 'Male', 40, 5, 35, 80, 35, 45, 70),
(57, 'Primeape', 1.0, 32.0, 'Fighting', 'Pig Monkey', 159, 'Female', 65, 28, 60, 105, 60, 70, 95),

-- Rock Pokémon
(74, 'Geodude', 0.4, 20.0, 'Rock/Ground', 'Rock', 86, 'Male', 40, 10, 30, 80, 100, 30, 20),
(75, 'Graveler', 1.0, 105.0, 'Rock/Ground', 'Rock', 134, 'Male', 55, 25, 45, 95, 115, 45, 35),

-- Psychic Pokémon
(63, 'Abra', 0.9, 19.5, 'Psychic', 'Psi', 62, 'Female', 25, 5, 105, 20, 15, 55, 90),
(65, 'Alakazam', 1.5, 48.0, 'Psychic', 'Psi', 225, 'Male', 55, 36, 135, 50, 45, 95, 120),

-- Ghost Pokémon
(92, 'Gastly', 1.3, 0.1, 'Ghost/Poison', 'Gas', 62, 'Male', 30, 5, 100, 35, 30, 35, 80),
(94, 'Gengar', 1.5, 40.5, 'Ghost/Poison', 'Shadow', 225, 'Female', 60, 36, 130, 65, 60, 75, 110),

-- Dragon Pokémon
(147, 'Dratini', 1.8, 3.3, 'Dragon', 'Dragon', 60, 'Male', 41, 5, 50, 64, 45, 50, 50),
(148, 'Dragonair', 4.0, 16.5, 'Dragon', 'Dragon', 147, 'Female', 61, 30, 70, 84, 65, 70, 70),
(149, 'Dragonite', 2.2, 210.0, 'Dragon/Flying', 'Dragon', 270, 'Male', 91, 55, 100, 134, 95, 100, 80),

-- Legendary Pokémon
(150, 'Mewtwo', 2.0, 122.0, 'Psychic', 'Genetic', 306, 'Genderless', 106, 70, 154, 110, 90, 154, 130),
(151, 'Mew', 0.4, 4.0, 'Psychic', 'New Species', 270, 'Genderless', 100, 70, 100, 100, 100, 100, 100);


-- Pokemon Types
INSERT INTO Poke_Type (Pokemon_Number, Type, Weak_Against, Immune_To, Strong_Against) VALUES
(1, 'Grass', 'Fire', NULL, 'Water'),
(1, 'Poison', 'Psychic', NULL, 'Grass'),
(2, 'Grass', 'Fire', NULL, 'Water'),
(2, 'Poison', 'Psychic', NULL, 'Grass'),
(3, 'Grass', 'Fire', NULL, 'Water'),
(3, 'Poison', 'Psychic', NULL, 'Grass'),
(4, 'Fire', 'Water', NULL, 'Grass'),
(5, 'Fire', 'Water', NULL, 'Grass'),
(6, 'Fire', 'Water', NULL, 'Grass'),
(6, 'Flying', 'Electric', 'Ground', 'Fighting'),
(7, 'Water', 'Electric', NULL, 'Fire'),
(8, 'Water', 'Electric', NULL, 'Fire'),
(9, 'Water', 'Electric', NULL, 'Fire'),
(10, 'Bug', 'Fire', NULL, 'Grass'),
(12, 'Bug', 'Fire', NULL, 'Grass'),
(12, 'Flying', 'Electric', 'Ground', 'Fighting'),
(13, 'Bug', 'Fire', NULL, 'Grass'),
(15, 'Bug', 'Fire', NULL, 'Grass'),
(15, 'Poison', 'Psychic', NULL, 'Grass'),
(16, 'Normal', 'Fighting', NULL, NULL),
(16, 'Flying', 'Electric', 'Ground', 'Fighting'),
(18, 'Normal', 'Fighting', NULL, NULL),
(18, 'Flying', 'Electric', 'Ground', 'Fighting'),
(19, 'Normal', 'Fighting', NULL, NULL),
(20, 'Normal', 'Fighting', NULL, NULL),
(25, 'Electric', 'Ground', NULL, 'Flying'),
(26, 'Electric', 'Ground', NULL, 'Flying'),
(56, 'Fighting', 'Psychic', NULL, 'Normal'),
(57, 'Fighting', 'Psychic', NULL, 'Normal'),
(63, 'Psychic', 'Bug', NULL, 'Fighting'),
(65, 'Psychic', 'Bug', NULL, 'Fighting'),
(74, 'Rock', 'Water', NULL, 'Fire'),
(74, 'Ground', 'Water', 'Electric', 'Fire'),
(75, 'Rock', 'Water', NULL, 'Fire'),
(75, 'Ground', 'Water', 'Electric', 'Fire'),
(92, 'Ghost', 'Dark', 'Normal', 'Psychic'),
(92, 'Poison', 'Psychic', NULL, 'Grass'),
(94, 'Ghost', 'Dark', 'Normal', 'Psychic'),
(94, 'Poison', 'Psychic', NULL, 'Grass'),
(147, 'Dragon', 'Ice', NULL, 'Dragon'),
(148, 'Dragon', 'Ice', NULL, 'Dragon'),
(149, 'Dragon', 'Ice', NULL, 'Dragon'),
(149, 'Flying', 'Electric', 'Ground', 'Fighting'),
(150, 'Psychic', 'Bug', NULL, 'Fighting'),
(151, 'Psychic', 'Bug', NULL, 'Fighting');


-- Pokemon Moves
INSERT INTO Moves (Move_Name, Type, Category, Power, Accuracy, Contact, PP, Pokemon_Number) VALUES
-- Bulbasaur
('Tackle', 'Normal', 'Physical', 40, 100, TRUE, 35, 1),
('Vine Whip', 'Grass', 'Physical', 45, 100, TRUE, 25, 1),

-- Ivysaur
('Razor Leaf', 'Grass', 'Physical', 55, 95, TRUE, 25, 2),
('Sleep Powder', 'Grass', 'Status', NULL, 75, FALSE, 15, 2),

-- Venusaur
('Solar Beam', 'Grass', 'Special', 120, 100, FALSE, 10, 3),
('Sludge Bomb', 'Poison', 'Special', 90, 100, FALSE, 10, 3),

-- Charmander
('Scratch', 'Normal', 'Physical', 40, 100, TRUE, 35, 4),
('Ember', 'Fire', 'Special', 40, 100, FALSE, 25, 4),

-- Charmeleon
('Flamethrower', 'Fire', 'Special', 90, 100, FALSE, 15, 5),
('Dragon Rage', 'Dragon', 'Special', 40, 100, FALSE, 10, 5),

-- Charizard
('Fire Spin', 'Fire', 'Special', 35, 85, FALSE, 15, 6),
('Wing Attack', 'Flying', 'Physical', 60, 100, TRUE, 35, 6),

-- Squirtle
('Water Gun', 'Water', 'Special', 40, 100, FALSE, 25, 7),
('Withdraw', 'Water', 'Status', NULL, 100, FALSE, 40, 7),

-- Wartortle
('Bubble', 'Water', 'Special', 40, 100, FALSE, 30, 8),
('Bite', 'Dark', 'Physical', 60, 100, TRUE, 25, 8),

-- Blastoise
('Hydro Pump', 'Water', 'Special', 110, 80, FALSE, 5, 9),
('Skull Bash', 'Normal', 'Physical', 130, 100, TRUE, 10, 9),

-- Caterpie
('String Shot', 'Bug', 'Status', NULL, 95, FALSE, 40, 10),
('Tackle', 'Normal', 'Physical', 40, 100, TRUE, 35, 10),

-- Butterfree
('Gust', 'Flying', 'Special', 40, 100, FALSE, 35, 12),
('Confusion', 'Psychic', 'Special', 50, 100, FALSE, 25, 12),

-- Weedle
('Poison Sting', 'Poison', 'Physical', 15, 100, TRUE, 35, 13),
('String Shot', 'Bug', 'Status', NULL, 95, FALSE, 40, 13),

-- Beedrill
('Twineedle', 'Bug', 'Physical', 25, 100, TRUE, 20, 15),
('Agility', 'Psychic', 'Status', NULL, 100, FALSE, 30, 15),

-- Pidgey
('Quick Attack', 'Normal', 'Physical', 40, 100, TRUE, 30, 16),
('Sand Attack', 'Ground', 'Status', NULL, 100, FALSE, 15, 16),

-- Pidgeot
('Aerial Ace', 'Flying', 'Physical', 60, NULL, TRUE, 20, 18),
('Hurricane', 'Flying', 'Special', 110, 70, FALSE, 10, 18),

-- Rattata
('Hyper Fang', 'Normal', 'Physical', 80, 90, TRUE, 15, 19),
('Tail Whip', 'Normal', 'Status', NULL, 100, FALSE, 30, 19),

-- Raticate
('Super Fang', 'Normal', 'Physical', NULL, 90, TRUE, 10, 20),
('Crunch', 'Dark', 'Physical', 80, 100, TRUE, 15, 20),

-- Pikachu
('Thunder Shock', 'Electric', 'Special', 40, 100, FALSE, 30, 25),
('Quick Attack', 'Normal', 'Physical', 40, 100, TRUE, 30, 25),

-- Raichu
('Thunderbolt', 'Electric', 'Special', 90, 100, FALSE, 15, 26),
('Iron Tail', 'Steel', 'Physical', 100, 75, TRUE, 15, 26),

-- Mankey
('Karate Chop', 'Fighting', 'Physical', 50, 100, TRUE, 25, 56),
('Focus Energy', 'Normal', 'Status', NULL, 100, FALSE, 30, 56),

-- Primeape
('Cross Chop', 'Fighting', 'Physical', 100, 80, TRUE, 5, 57),
('Rage', 'Normal', 'Physical', 20, 100, TRUE, 20, 57),

-- Abra
('Teleport', 'Psychic', 'Status', NULL, NULL, FALSE, 20, 63),
('Confusion', 'Psychic', 'Special', 50, 100, FALSE, 25, 63),

-- Alakazam
('Psybeam', 'Psychic', 'Special', 65, 100, FALSE, 20, 65),
('Recover', 'Psychic', 'Status', NULL, NULL, FALSE, 20, 65),

-- Geodude
('Rock Throw', 'Rock', 'Physical', 50, 90, TRUE, 15, 74),
('Defense Curl', 'Normal', 'Status', NULL, NULL, FALSE, 40, 74),

-- Graveler
('Earthquake', 'Ground', 'Physical', 100, 100, TRUE, 10, 75),
('Rock Slide', 'Rock', 'Physical', 75, 90, TRUE, 10, 75),

-- Gastly
('Lick', 'Ghost', 'Physical', 30, 100, TRUE, 30, 92),
('Hypnosis', 'Psychic', 'Status', NULL, 60, FALSE, 20, 92),

-- Gengar
('Shadow Ball', 'Ghost', 'Special', 80, 100, FALSE, 15, 94),
('Dream Eater', 'Psychic', 'Special', 100, 100, FALSE, 15, 94),

-- Dratini
('Wrap', 'Normal', 'Physical', 15, 90, TRUE, 20, 147),
('Dragon Rage', 'Dragon', 'Special', 40, 100, FALSE, 10, 147),

-- Dragonair
('Thunder Wave', 'Electric', 'Status', NULL, 90, FALSE, 20, 148),
('Slam', 'Normal', 'Physical', 80, 75, TRUE, 20, 148),

-- Dragonite
('Outrage', 'Dragon', 'Physical', 120, 100, TRUE, 10, 149),
('Hyper Beam', 'Normal', 'Special', 150, 90, FALSE, 5, 149),

-- Mewtwo
('Psychic', 'Psychic', 'Special', 90, 100, FALSE, 10, 150),
('Barrier', 'Psychic', 'Status', NULL, NULL, FALSE, 30, 150),

-- Mew
('Metronome', 'Normal', 'Status', NULL, NULL, FALSE, 10, 151),
('Transform', 'Normal', 'Status', NULL, NULL, FALSE, 10, 151);


--Pokemon Move Types
INSERT INTO Move_Type (Move_Name, Poke_Name) VALUES
-- Bulbasaur
('Tackle', 'Bulbasaur'),
('Vine Whip', 'Bulbasaur'),

-- Ivysaur
('Razor Leaf', 'Ivysaur'),
('Sleep Powder', 'Ivysaur'),

-- Venusaur
('Solar Beam', 'Venusaur'),
('Sludge Bomb', 'Venusaur'),

-- Charmander
('Scratch', 'Charmander'),
('Ember', 'Charmander'),

-- Charmeleon
('Flamethrower', 'Charmeleon'),
('Dragon Rage', 'Charmeleon'),

-- Charizard
('Fire Spin', 'Charizard'),
('Wing Attack', 'Charizard'),

-- Squirtle
('Water Gun', 'Squirtle'),
('Withdraw', 'Squirtle'),

-- Wartortle
('Bubble', 'Wartortle'),
('Bite', 'Wartortle'),

-- Blastoise
('Hydro Pump', 'Blastoise'),
('Skull Bash', 'Blastoise'),

-- Caterpie
('String Shot', 'Caterpie'),
('Tackle', 'Caterpie'),

-- Butterfree
('Gust', 'Butterfree'),
('Confusion', 'Butterfree'),

-- Weedle
('Poison Sting', 'Weedle'),
('String Shot', 'Weedle'),

-- Beedrill
('Twineedle', 'Beedrill'),
('Agility', 'Beedrill'),

-- Pidgey
('Quick Attack', 'Pidgey'),
('Sand Attack', 'Pidgey'),

-- Pidgeot
('Aerial Ace', 'Pidgeot'),
('Hurricane', 'Pidgeot'),

-- Rattata
('Hyper Fang', 'Rattata'),
('Tail Whip', 'Rattata'),

-- Raticate
('Super Fang', 'Raticate'),
('Crunch', 'Raticate'),

-- Pikachu
('Thunder Shock', 'Pikachu'),
('Quick Attack', 'Pikachu'),

-- Raichu
('Thunderbolt', 'Raichu'),
('Iron Tail', 'Raichu'),

-- Mankey
('Karate Chop', 'Mankey'),
('Focus Energy', 'Mankey'),

-- Primeape
('Cross Chop', 'Primeape'),
('Rage', 'Primeape'),

-- Abra
('Teleport', 'Abra'),
('Confusion', 'Abra'),

-- Alakazam
('Psybeam', 'Alakazam'),
('Recover', 'Alakazam'),

-- Geodude
('Rock Throw', 'Geodude'),
('Defense Curl', 'Geodude'),

-- Graveler
('Earthquake', 'Graveler'),
('Rock Slide', 'Graveler'),

-- Gastly
('Lick', 'Gastly'),
('Hypnosis', 'Gastly'),

-- Gengar
('Shadow Ball', 'Gengar'),
('Dream Eater', 'Gengar'),

-- Dratini
('Wrap', 'Dratini'),
('Dragon Rage', 'Dratini'),

-- Dragonair
('Thunder Wave', 'Dragonair'),
('Slam', 'Dragonair'),

-- Dragonite
('Outrage', 'Dragonite'),
('Hyper Beam', 'Dragonite'),

-- Mewtwo
('Psychic', 'Mewtwo'),
('Barrier', 'Mewtwo'),

-- Mew
('Metronome', 'Mew'),
('Transform', 'Mew');


-- Rival Trainers
INSERT INTO Rival_Trainer (Trainer_No, Name) VALUES
(201, 'Gary'),
(202, 'Blue'),
(203, 'Silver'),
(204, 'Brendan'),
(205, 'May'),
(206, 'Wally');


-- Bag Items
-- Pokeballs
INSERT INTO Bag_Items (Item_Number, Pokeball_Type, Item_Name, Berry_Name)
VALUES
(1, 'Pokéball', NULL, NULL),
(2, 'Great Ball', NULL, NULL),
(3, 'Ultra Ball', NULL, NULL),
(4, 'Master Ball', NULL, NULL),
(5, 'Heal Ball', NULL, NULL),
(6, 'Premier Ball', NULL, NULL),
(7, 'Safari Ball', NULL, NULL),

-- Berries
(8, NULL, NULL, 'Oran Berry'),
(9, NULL, NULL, 'Leppa Berry'),
(10, NULL, NULL, 'Cheri Berry'),
(11, NULL, NULL, 'Chesto Berry'),
(12, NULL, NULL, 'Pecha Berry'),
(13, NULL, NULL, 'Aspear Berry'),
(14, NULL, NULL, 'Iapapa Berry'),
(15, NULL, NULL, 'Tanga Berry'),

-- Normal Items
(16, NULL, 'Potion', NULL),
(17, NULL, 'Super Potion', NULL),
(18, NULL, 'Hyper Potion', NULL),
(19, NULL, 'Max Potion', NULL),
(20, NULL, 'Revive', NULL),
(21, NULL, 'HP Up', NULL),
(22, NULL, 'Protein', NULL),
(23, NULL, 'Iron', NULL),
(24, NULL, 'Antidote', NULL),
(25, NULL, 'Paralyze Heal', NULL),
(26, NULL, 'Awakening', NULL),
(27, NULL, 'Burn Heal', NULL),
(28, NULL, 'Ice Heal', NULL),
(29, NULL, 'Full Restore', NULL),
(30, NULL, 'Full Heal', NULL);



-- Ailments and Cures
INSERT INTO Ailment_and_Cure (Berry_Name, Item_Name, Ail_Name)
VALUES
-- Cures using berries
('Cheri Berry', NULL, 'Paralysis'),
('Chesto Berry', NULL, 'Burn'),
('Pecha Berry', NULL, 'Poison'),
('Aspear Berry', NULL, 'Sleep'),
('Iapapa Berry', NULL, 'Freeze'),
('Tanga Berry', NULL, 'Confusion'),

-- Cures using normal items
(NULL, 'Antidote', 'Poison'),
(NULL, 'Paralyze Heal', 'Paralysis'),
(NULL, 'Burn Heal', 'Burn'),
(NULL, 'Awakening', 'Sleep'),
(NULL, 'Ice Heal', 'Freeze'),
(NULL, 'Full Restore', 'Confusion'),
(NULL, 'Full Heal', 'Flinching'),
(NULL, 'Revive', 'Fainted');

-- Populating the Battle table with updated Pokemon_Used values
INSERT INTO Battle (Battle_Number, Battle_Type, Pokemon_Used, Date, Outcome)
VALUES
(1, 'Gym Battle', 63, '2024-11-01', 'Win'),    -- Gym Battle 1 (Pewter City, Brock)
(2, 'Trainer Battle', 65, '2024-11-02', 'Win'), -- Rival Battle 1 (Trainer 1)
(3, 'Gym Battle', 15, '2024-11-05', 'Win'),    -- Gym Battle 2 (Cerulean City, Misty)
(4, 'Trainer Battle', 9, '2024-11-06', 'Lose'), -- Rival Battle 2 (Trainer 2)
(5, 'Gym Battle', 1, '2024-11-07', 'Win'),     -- Gym Battle 3 (Vermilion City, Lt. Surge)
(6, 'Trainer Battle', 12, '2024-11-08', 'Win'), -- Rival Battle 3 (Trainer 3)
(7, 'Gym Battle', 10, '2024-11-10', 'Win'),    -- Gym Battle 4 (Celadon City, Erika)
(8, 'Gym Battle', 6, '2024-11-12', 'Win'),     -- Gym Battle 5 (Fuchsia City, Koga)
(9, 'Gym Battle', 4, '2024-11-14', 'Lose'),    -- Gym Battle 6 (Saffron City, Sabrina)
(10, 'Gym Battle', 5, '2024-11-16', 'Win'),    -- Gym Battle 7 (Cinnabar Island, Blaine)
(11, 'Trainer Battle', 148, '2024-11-18', 'Win'), -- Rival Battle 4 (Trainer 4)
(12, 'Trainer Battle', 149, '2024-11-20', 'Win'); -- Rival Battle 5 (Trainer 5)

-- Populating the Gym_Battle table
INSERT INTO Gym_Battle (Battle_Number, Gym, Gym_Leader)
VALUES
(1, 'Pewter City', 'Brock'),      -- Gym Battle 1
(3, 'Cerulean City', 'Misty'),    -- Gym Battle 2
(5, 'Vermilion City', 'Lt. Surge'),  -- Gym Battle 3
(7, 'Celadon City', 'Erika'),     -- Gym Battle 4
(8, 'Fuchsia City', 'Koga'),      -- Gym Battle 5
(9, 'Saffron City', 'Sabrina'),   -- Gym Battle 6
(10, 'Cinnabar Island', 'Blaine'); -- Gym Battle 7

-- Populating the Normal_Battle table
INSERT INTO Normal_Battle (Battle_Number, Location, Rival_ID)
VALUES
(2, 'Route 1', 201),  -- Rival Battle 1 (Trainer 1 at Route 1)
(4, 'Route 2', 202),  -- Rival Battle 2 (Trainer 2 at Route 2)
(6, 'Route 3', 203),  -- Rival Battle 3 (Trainer 3 at Route 3)
(11, 'Route 4', 204), -- Rival Battle 4 (Trainer 4 at Route 4)
(12, 'Route 5', 205); -- Rival Battle 5 (Trainer 5 at Route 5)


-- Populating the Battling_Gym_Leader table
INSERT INTO Battling_Gym_Leader (Battle_Number, Pokemon_Number, Location)
VALUES
(1, 63, 'Pewter City'),   
(3, 15, 'Cerulean City'), 
(5, 1, 'Vermilion City'), 
(7, 10, 'Celadon City'),  
(8, 6, 'Fuchsia City'),  
(9, 4, 'Saffron City'),   
(10, 5, 'Cinnabar Island');

-- Populating the Battling_Rival table
INSERT INTO Battling_Rival_Trainer (Battle_Number, Pokemon_Number, Trainer_No) VALUES
(2, 65, 201), 
(4, 9, 202),  
(6, 12, 203), 
(11, 148, 204),
(12, 149, 205);
