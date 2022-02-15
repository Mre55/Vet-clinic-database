/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS(
   ID               INT             NOT NULL,
   NAME             VARCHAR(50)     NOT NULL,
   DATE_OF_BIRTH    DATE            NOT NULL,
   ESCAPE_ATTEMPTS  INT             NOT NULL,
   NEUTERED         BOOLEAN         NOT NULL,
   WEIGHT_KG        DECIMAL (5, 2)  NOT NULL,
);

/* Vet clinic database: query and update animals table */

ALTER TABLE ANIMALS ADD SPECIES VARCHAR(50);