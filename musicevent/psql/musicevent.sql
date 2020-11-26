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

INSERT INTO MusicType (name) VALUES ('Metal'),('Rock'), ('Classic'), ('Jazz'), ('Electro');

CREATE TABLE Band
(
    id SERIAL PRIMARY KEY,
    idMusicType integer NOT NULL,
    name varchar (50) NOT NULL,
    mediaUrl text DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    FOREIGN KEY (idMusicType) REFERENCES MusicType(id)
);

INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'Powerwolf','https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'Sabaton','https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515371_10629.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'System Of A Down','https://www.lagrosseradio.com/webzine/images/15743.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (2,'ACDC','https://i.ytimg.com/vi/9FzC5881E4s/maxresdefault.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'As I Lay Dying','https://www.rockurlife.net/wp-content/uploads/2019/09/ShapedByFIre.jpg');

CREATE TABLE Country
(
    id SERIAL PRIMARY KEY,
    name varchar (50) NOT NULL
);

INSERT INTO Country (name) VALUES ('France'),('Deutschland'),('Belgium'),('Switzerland'),('Italy'),('Spain'),('United Kingdom');

CREATE TABLE City
(
    id SERIAL PRIMARY KEY,
    idCountry integer NOT NULL,
    name varchar (50) NOT NULL,
    FOREIGN KEY (idCountry) REFERENCES Country(id)
);

INSERT INTO City (idCountry, name) VALUES (1, 'Paris'), (1, 'Marseille'), (1, 'Toulouse'), (1, 'Bordeaux');
INSERT INTO City (idCountry, name) VALUES (2, 'Berlin'), (2, 'Munich'), (2, 'Hambourg'), (2, 'Cologne');
INSERT INTO City (idCountry, name) VALUES (3, 'Liège'), (3, 'Bruxelles'), (3, 'Bruges'), (3, 'Anvers');
INSERT INTO City (idCountry, name) VALUES (4, 'Zurich'), (4, 'Genève'), (4, 'Lausanne'), (4, 'Montreux');
INSERT INTO City (idCountry, name) VALUES (5, 'Rome'), (5, 'Venise'), (5, 'Florence'), (5, 'Milan');
INSERT INTO City (idCountry, name) VALUES (6, 'Madrid'), (6, 'Barcelone'), (6, 'Valence'), (6, 'Séville');
INSERT INTO City (idCountry, name) VALUES (7, 'London'), (7, 'Manchester'), (7, 'Liverpool'), (7, 'Edimbourg');

CREATE TABLE Concert
(
    id SERIAL PRIMARY KEY,
    idBand integer NOT NULL,
    idCity integer NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (idBand) REFERENCES Band(id),
    FOREIGN KEY (idCity) REFERENCES City(id)
);

INSERT INTO Concert (idBand, idCity, date) VALUES (1, 1, '2021-02-15'), (2, 3, '2021-02-05'), (2, 5, '2021-05-10');


CREATE TABLE Reservation
(
    id SERIAL PRIMARY KEY,
    idConcert integer NOT NULL,
    firstName varchar (50) NOT NULL,
    lastName varchar (50) NOT NULL,
    email varchar (255),
    date timestamp NOT NULL DEFAULT NOW(),
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
