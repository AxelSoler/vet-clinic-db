/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int PRIMARY KEY,
    name varchar(40),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals
ADD species varchar(40);


-- new tables

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(255),
    age int
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(255)
);

ALTER TABLE animals 
    DROP COLUMN id

ALTER TABLE animals
    ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE animals
    DROP COLUMN species;

ALTER TABLE animals
    ADD COLUMN species_id integer REFERENCES species(id);

ALTER TABLE animals 
    ADD COLUMN owner_id integer REFERENCES owners(id)

-- many to many tables

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(255),
    age int,
    date_of_graduation date
);

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id integer REFERENCES vets(id),
    species_id integer REFERENCES species(id)
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id integer REFERENCES animals(id),
    vet_id integer REFERENCES vets(id),
    date date
);