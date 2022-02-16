/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS (
   ID               INT             NOT NULL,
   NAME             VARCHAR(50)     NOT NULL,
   DATE_OF_BIRTH    DATE            NOT NULL,
   ESCAPE_ATTEMPTS  INT             NOT NULL,
   NEUTERED         BOOLEAN         NOT NULL,
   WEIGHT_KG        DECIMAL (5, 2)  NOT NULL,
);


/* Vet clinic database: query and update animals table */

ALTER TABLE ANIMALS ADD SPECIES VARCHAR(50);


/* Vet clinic database: query multiple tables */

CREATE TABLE OWNERS (
   ID               SERIAL PRIMARY KEY,
   FULL_NAME        VARCHAR(100)        NOT NULL,
   AGE              INT                 NOT NULL
);


CREATE TABLE SPECIES (
   ID               SERIAL PRIMARY KEY,
   NAME             VARCHAR(50)         NOT NULL
);


ALTER TABLE ANIMALS DROP COLUMN ID;
ALTER TABLE ANIMALS ADD  COLUMN ID SERIAL PRIMARY KEY;
ALTER TABLE ANIMALS DROP COLUMN SPECIES;
ALTER TABLE ANIMALS ADD  COLUMN SPECIES_ID INT REFERENCES SPECIES;
ALTER TABLE ANIMALS ADD  COLUMN OWNER_ID INT REFERENCES OWNERS;