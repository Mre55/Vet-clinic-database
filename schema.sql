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


/* Vet clinic database: add "join table" for visits */

CREATE TABLE VETS (
   ID                   SERIAL PRIMARY KEY,
   NAME                 VARCHAR(50)         NOT NULL,
   AGE                  INT                 NOT NULL,
   DATE_OF_GRADUATION   DATE                NOT NULL
);


CREATE TABLE SPECIALIZATIONS (
	SPECIES_ID                  INT NOT NULL,
	VETS_ID                     INT NOT NULL,
	FOREIGN KEY (SPECIES_ID) REFERENCES SPECIES (ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (VETS_ID) REFERENCES VETS (ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY (SPECIES_ID, VETS_ID)
);


CREATE TABLE VISITS (
	ANIMALS_ID                  INT     NOT NULL,
	VETS_ID                     INT     NOT NULL,
    DATE_OF_VIST                DATE    NOT NULL,
	FOREIGN KEY (ANIMALS_ID) REFERENCES ANIMALS (ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (VETS_ID) REFERENCES VETS (ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY (ANIMALS_ID, VETS_ID, DATE_OF_VIST)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
create index visits_animal_id_asc on visits(animals_id asc);
create index visits_vet_id_desc on visits(vets_id desc);
create index owners_email_asc on owners(email asc);