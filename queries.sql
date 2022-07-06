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


-- PART 3
-- Write queries (using JOIN) to answer the following questions:

-- What animals belong to Melody Pond?

SELECT
    owner_id,
    name,
    full_name
FROM
    animals
INNER JOIN owners
    ON animals.owner_id = owners.id
    WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name, species.name
FROM
    animals
INNER JOIN species
    ON animals.species_id = species.id
    WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.full_name, animals.name
FROM
    animals
RIGHT JOIN owners
    ON animals.owner_id = owners.id

-- How many animals are there per species?

SELECT species.name, COUNT(*)
FROM
    animals
INNER JOIN species
    ON animals.species_id = species.id
    GROUP BY species.name

-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name, owners.full_name
FROM
    animals
INNER JOIN owners
    ON animals.owner_id = owners.id
INNER JOIN species
    ON animals.species_id = species.id
    WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name, owners.full_name
FROM
    animals
INNER JOIN owners
    ON animals.owner_id = owners.id
    WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?

SELECT owners.full_name, COUNT(*)
FROM
    animals
INNER JOIN owners
    ON animals.owner_id = owners.id
    GROUP BY owners.full_name
    ORDER BY COUNT(owner_id) DESC
    LIMIT 1;


-- Write queries to answer the following:

-- Who was the last animal seen by William Tatcher?
SELECT animals.name
FROM animals
INNER JOIN visits
     ON animals.id = visits.animal_id
INNER JOIN vets
     ON visits.vet_id = vets.id
     WHERE vets.name = 'William Tatcher'
     ORDER BY visits.date DESC
     LIMIT 1

-- How many different animals did Stephanie Mendez see?
SELECT animals.name
FROM animals
INNER JOIN visits
     ON animals.id = visits.animal_id
INNER JOIN vets
     ON visits.vet_id = vets.id
     WHERE vets.name = 'Stephanie Mendez'

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
     ON vets.id = specializations.vet_id
LEFT JOIN species
     ON specializations.species_id = species.id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date
FROM animals
INNER JOIN visits
     ON animals.id = visits.id
INNER JOIN vets
     ON visits.vet_id = vets.id
     WHERE date >= '2020-04-01' AND date <= '2020-08-30' AND vets.name = 'Stephanie Mendez'

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*)
FROM animals
INNER JOIN visits
     ON animals.id = visits.animal_id
     GROUP BY animals.name
     ORDER BY COUNT(*) DESC
     LIMIT 1

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date
FROM animals
INNER JOIN visits
     ON animals.id = visits.animal_id
INNER JOIN vets
     ON visits.vet_id = vets.id
     WHERE vets.name = 'Maisy Smith'
     ORDER BY visits.date ASC
     LIMIT 1

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, visits.date
FROM animals
INNER JOIN visits
     ON animals.id = visits.animal_id
INNER JOIN vets
     ON visits.vet_id = vets.id
     ORDER BY visits.date DESC
     LIMIT 1

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits
INNER JOIN animals
     ON visits.animal_id = animals.id
INNER JOIN vets
     ON visits.vet_id = vets.id
INNER JOIN specializations
     ON vets.id = specializations.vet_id
INNER JOIN species
     ON specializations.species_id = species.id
     WHERE animals.species_id NOT IN (
       SELECT specializations.species_id FROM vets
         JOIN specializations ON vets.id = specializations.vet_id
         WHERE vets.id = visits.vet_id
     );

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name
FROM vets
JOIN visits
    ON vets.id = visits.vet_id
JOIN animals
    ON visits.animal_id = animals.id
JOIN species
    ON animals.species_id = species.id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name
    LIMIT 1;