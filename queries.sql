/*Queries that provide answers to the questions from all projects.*/


-- Find all animals whose name ends in "mon".
SELECT * FROM animals where name LIKE '%mon'

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth < '2020-01-01'

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.5

-- Find all animals that are neutered.
SELECT name FROM animals WHERE neutered = TRUE

-- Find all animals not named Gabumon.
SELECT name FROM animals WHERE name != 'Gabumon'

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3


-- PART 2

-- Inside a transaction update the animals table by setting the species column to unspecified.
BEGIN;

UPDATE animals
SET species = 'unspecified'

-- Then roll back the change and verify that the species columns went back to the state before the transaction.
ROLLBACK

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon'


-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
set species = 'pokemon'
WHERE name NOT LIKE '%mon'

COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

DELETE FROM animals
ROLLBACK

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT SP1

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
set weight_kg = weight_kg * -1

-- Rollback to the savepoint
ROLLBACK TO SP1

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0

-- Commit transaction

COMMIT


-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered FROM animals
WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT (MAX(weight_kg), MIN(weight_kg), species) FROM animals GROUP BY species

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts), species FROM animals
  GROUP BY species
  WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
