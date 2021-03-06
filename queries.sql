/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM ANIMALS WHERE NAME LIKE '%mon';
SELECT NAME FROM ANIMALS WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-01-01';
SELECT NAME FROM ANIMALS WHERE NEUTERED = TRUE AND ESCAPE_ATTEMPTS < 3;
SELECT DATE_OF_BIRTH FROM ANIMALS WHERE NAME = 'Agumon' OR NAME = 'Pikachu';
SELECT NAME, ESCAPE_ATTEMPTS FROM ANIMALS WHERE WEIGHT_KG > 10.5;
SELECT * FROM ANIMALS WHERE NEUTERED = TRUE;
SELECT * FROM ANIMALS WHERE NAME != 'Gabumon';
SELECT * FROM ANIMALS WHERE WEIGHT_KG BETWEEN 10.40 AND 17.30;

/* Vet clinic database: query and update animals table */

SELECT COUNT(*) FROM ANIMALS;
SELECT COUNT(ESCAPE_ATTEMPTS) FROM ANIMALS WHERE ESCAPE_ATTEMPTS='0';
SELECT AVG(WEIGHT_KG) FROM ANIMALS;
SELECT NEUTERED, SUM(ESCAPE_ATTEMPTS) FROM ANIMALS GROUP BY NEUTERED;
SELECT SPECIES, MIN(WEIGHT_KG), MAX(WEIGHT_KG) FROM ANIMALS GROUP BY SPECIES;
SELECT DATE_OF_BIRTH, AVG(ESCAPE_ATTEMPTS) FROM ANIMALS WHERE DATE_OF_BIRTH BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY DATE_OF_BIRTH;


/* Transactions 1 */

BEGIN;
UPDATE ANIMALS SET SPECIES = 'digimon' WHERE NAME LIKE '%mon';
UPDATE ANIMALS SET SPECIES = 'pokemon' WHERE SPECIES='';
COMMIT;


/* Transactions 2 */

BEGIN;
DELETE FROM ANIMALS;
ROLLBACK;


/* Transactions 3 */

BEGIN;
DELETE FROM ANIMALS WHERE DATE_OF_BIRTH>'2022-01-01';
SAVEPOINT SP1;
UPDATE ANIMALS SET WEIGHT_KG=WEIGHT_KG*(-1);
ROLLBACK TO SP1;
COMMIT;


/* Vet clinic database: query multiple tables */

SELECT FULL_NAME, NAME FROM ANIMALS A INNER JOIN OWNERS O ON A.OWNER_ID = O.ID WHERE O.FULL_NAME='Melody Pond';
SELECT A.NAME FROM ANIMALS A JOIN SPECIES S ON A.SPECIES_ID = S.ID WHERE A.SPECIES_ID=1;
SELECT FULL_NAME, NAME FROM OWNERS O LEFT JOIN ANIMALS A ON O.ID = A.OWNER_ID;
SELECT S.NAME, COUNT(SPECIES_ID) FROM ANIMALS A JOIN SPECIES S ON A.SPECIES_ID=S.ID GROUP BY S.NAME;
SELECT FULL_NAME, S.NAME FROM OWNERS O JOIN ANIMALS A ON O.ID=A.OWNER_ID JOIN SPECIES S ON S.ID=O.ID WHERE O.ID=2;
SELECT FULL_NAME, A.NAME FROM ANIMALS A JOIN OWNERS O ON A.OWNER_ID=O.ID WHERE escape_attempts=0 AND FULL_NAME='Dean Winchester';
SELECT full_name, COUNT(full_name) FROM (
SELECT full_name FROM animals LEFT JOIN owners ON owner_id = owners.id) AS count GROUP BY full_name HAVING COUNT (full_name) = 
(SELECT MAX(count) FROM 
(SELECT full_name, COUNT(full_name) FROM animals LEFT JOIN owners ON owner_id = owners.id GROUP BY full_name) AS count);


/* Vet clinic database: add "join table" for visits */


SELECT A.NAME, VT.NAME, VS.DATE_OF_VIST FROM ANIMALS A JOIN VISITS VS ON (A.ID=VS.ANIMALS_ID) JOIN VETS VT ON (VT.ID=VS.VETS_ID) WHERE VT.NAME='William Tatcher' ORDER BY VS.DATE_OF_VIST DESC LIMIT 1;
SELECT A.NAME AS ANIMAL_NAME, VT.NAME AS VET_NAME, COUNT(A.NAME) FROM ANIMALS A JOIN VISITS VS ON (A.ID=VS.ANIMALS_ID) JOIN VETS VT ON (VT.ID=VS.VETS_ID) WHERE VT.NAME='Stephanie Mendez' GROUP BY VT.NAME, A.NAME;
SELECT V.NAME AS VET_NAME, S.NAME AS SPECIES_NAME FROM VETS V JOIN SPECIALIZATIONS SP ON (V.ID=SP.VETS_ID) JOIN SPECIES S ON (SP.SPECIES_ID=S.ID);
SELECT A.NAME, V.NAME, VS.DATE_OF_VIST FROM ANIMALS A JOIN VISITS VS ON A.ID=VS.ANIMALS_ID JOIN VETS V ON V.ID=VS.VETS_ID WHERE V.NAME='Stephanie Mendez' AND VS.DATE_OF_VIST BETWEEN '2020-08-01' AND '2020-08-31';
SELECT MAX(COUNT) FROM (SELECT A.NAME AS ANIMAL_NAME, V.NAME AS VET_NAME, COUNT(A.NAME) FROM ANIMALS A JOIN VISITS VS ON A.ID=VS.ANIMALS_ID JOIN VETS V ON V.ID=VS.VETS_ID GROUP BY A.NAME, V.NAME) AS COUNT;
SELECT A.NAME, VT.NAME, VS.DATE_OF_VIST FROM ANIMALS A JOIN VISITS VS ON (A.ID=VS.ANIMALS_ID) JOIN VETS VT ON (VT.ID=VS.VETS_ID) WHERE VT.NAME='Maisy Smith' ORDER BY VS.DATE_OF_VIST asc limit 1;
SELECT A.NAME, V.NAME, VS.DATE_OF_VIST FROM ANIMALS A JOIN VISITS VS ON A.ID=VS.ANIMALS_ID JOIN VETS V ON V.ID=VS.VETS_ID ORDER BY VS.DATE_OF_VIST DESC LIMIT 1;

SELECT A.NAME, V.NAME AS VET_NAME, SP.NAME AS VET_SPECIALITY, SPP.NAME AS ANIM_SPECIES  FROM ANIMALS A 
JOIN VISITS VS ON A.ID=VS.ANIMALS_ID 
JOIN VETS V ON V.ID=VS.VETS_ID
JOIN SPECIALIZATIONS S ON S.VETS_ID=V.ID
JOIN SPECIES SP ON SP.ID=S.SPECIES_ID
JOIN SPECIES SPP ON A.SPECIES_ID=SPP.ID WHERE SP.NAME!=SPP.NAME;

SELECT A.NAME AS ANIMAL_NAME, VT.NAME AS VET_NAME, SPP.NAME AS ANIM_SPECIES, COUNT(SPP.NAME) FROM ANIMALS A 
JOIN VISITS VS ON (A.ID=VS.ANIMALS_ID) 
JOIN VETS VT ON (VT.ID=VS.VETS_ID)
JOIN SPECIES SPP ON A.SPECIES_ID=SPP.ID WHERE VT.NAME='Maisy Smith' GROUP BY SPP.NAME, A.NAME, VT.NAME;
