-- CONNEXION A LA BDD
-- sudo docker exec -it musicevent_psql_1 bash
-- psql -U postgres postgres

-- DROP DATABASE IF EXISTS musicevent;
-- CREATE DATABASE musicevent;

DROP TABLE IF EXISTS MusicType;
DROP TABLE IF EXISTS Band;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Concert;
DROP TABLE IF EXISTS Reservation;


CREATE TABLE MusicType
(
    id SERIAL PRIMARY KEY,
    name varchar (100) NOT NULL
);

INSERT INTO MusicType (name) VALUES ('Metal'),('Power Metal'), ('Classic'), ('Jazz'), ('Electro');

CREATE TABLE Band
(
    id SERIAL PRIMARY KEY,
    idMusicType integer NOT NULL,
    name varchar (50) NOT NULL,
    mediaUrl text DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    FOREIGN KEY (idMusicType) REFERENCES MusicType(id)
);

INSERT INTO Band (idMusicType, name) VALUES (2,'Powerwolf');

CREATE TABLE Country
(
    id SERIAL PRIMARY KEY,
    name varchar (50) NOT NULL
);

INSERT INTO Country (name) VALUES ('France'),('Allemagne');

CREATE TABLE City
(
    id SERIAL PRIMARY KEY,
    idCountry integer NOT NULL,
    name varchar (50) NOT NULL,
    FOREIGN KEY (idCountry) REFERENCES Country(id)
);

INSERT INTO City (idCountry, name) VALUES (1, 'Paris'), (1, 'Marseille'), (1, 'Toulouse'), (1, 'Bordeaux');

CREATE TABLE Concert
(
    id SERIAL PRIMARY KEY,
    idBand integer NOT NULL,
    idCity integer NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (idBand) REFERENCES Band(id),
    FOREIGN KEY (idCity) REFERENCES City(id)
);

INSERT INTO Concert (idBand, idCity, date) VALUES (1, 1, '2021-02-15');


CREATE TABLE Reservation
(
    id SERIAL PRIMARY KEY,
    idConcert integer NOT NULL,
    firstName varchar (50) NOT NULL,
    lastName varchar (50) NOT NULL,
    email varchar (255),
    FOREIGN KEY (idConcert) REFERENCES Concert(id)
);

INSERT INTO Reservation (idConcert, firstName, lastName, email) VALUES (1, 'Virgile', 'Jallon', 'v.j@gmail.com');



-- Recherche par ville
/*SELECT Band.name, Band.mediaUrl, MusicType.name, date, City.name, Country.name FROM Concert
inner join City on City.id = idCity
inner join Country on Country.id = idCountry
inner join Band on Band.id = idBand
inner join MusicType on MusicType.id = idMusicType
where City.name like '%_____%';*/

-- Recherche par artiste
/*SELECT Band.name, Band.mediaUrl, MusicType.name, date, City.name, Country.name FROM Concert
inner join City on City.id = idCity
inner join Country on Country.id = idCountry
inner join Band on Band.id = idBand
inner join MusicType on MusicType.id = idMusicType
where Band.name like '%_____%';*/

-- Recherche par date
/*SELECT Band.name, Band.mediaUrl, MusicType.name, date, City.name, Country.name FROM Concert
inner join City on City.id = idCity
inner join Country on Country.id = idCountry
inner join Band on Band.id = idBand
inner join MusicType on MusicType.id = idMusicType
where date like '%_____%';*/

-- Effectuer réservation
/*INSERT INTO Reservation (idConcert, firstName, lastName, email) VALUES (?, ?, ?, ?);*/
