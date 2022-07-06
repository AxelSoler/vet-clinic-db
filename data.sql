/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03',  0, TRUE, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15',  2, TRUE, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07',  1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12',  5, TRUE, 11);

-- PART 2
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (5, 'Charmander', '2020-02-08',  0, FALSE, 11, 'NULL');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (6, 'Plantmon', '2021-11-15',  2, TRUE, 5.7, 'NULL');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (7, 'Squirtle', '1993-04-02',  3, FALSE, 12.13, 'NULL');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (8, 'Angemon', '2005-06-12',  1, TRUE, 45, 'NULL');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (9, 'Boarmon', '2005-06-07',  7, TRUE, 20.4, 'NULL');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (10, 'Blossom', '1998-10-13',  3, TRUE, 17, 'NULL');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES (11, 'Ditto', '2022-05-14',  4, TRUE, 22, 'NULL');

-- PART 3

INSERT INTO owners (full_name,age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name,age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name,age) VALUES ('Bob', 45);
INSERT INTO owners (full_name,age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name,age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name,age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals
set species = 1
WHERE name NOT LIKE '%mon'

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon'

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name = 'Pikachu' OR name = 'Gabumon';

UPDATE animals
SET owner_id = 3
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = 4
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name = 'Angemon' OR name = 'Boarmon';
