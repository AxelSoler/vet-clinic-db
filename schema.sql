/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int PRIMARY KEY,
    name varchar(40),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);
