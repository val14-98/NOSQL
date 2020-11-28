-- CONNEXION A LA BDD
-- sudo docker exec -it musicevent_psql_1 bash
-- psql -U postgres postgres

-- DROP DATABASE IF EXISTS musicevent;
-- CREATE DATABASE musicevent;

-- TODO : Modifier dates dans Reservation

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

INSERT INTO MusicType (name) VALUES ('Metal'), ('Rock'), ('Classic'), ('Jazz'), ('Electro');

CREATE TABLE Band
(
    id SERIAL PRIMARY KEY,
    idMusicType integer NOT NULL,
    name varchar (50) NOT NULL,
    mediaUrl text DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    FOREIGN KEY (idMusicType) REFERENCES MusicType(id)
);

INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'POWERWOLF','https://images-na.ssl-images-amazon.com/images/I/91Vc6ZS1kQL._SL1500_.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'SABATON','https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515371_10629.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'System Of A Down','https://www.lagrosseradio.com/webzine/images/15743.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (2,'ACDC','https://i.ytimg.com/vi/9FzC5881E4s/maxresdefault.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'As I Lay Dying','https://www.rockurlife.net/wp-content/uploads/2019/09/ShapedByFIre.jpg');

CREATE TABLE Country
(
    id SERIAL PRIMARY KEY,
    name varchar (50) NOT NULL
);

INSERT INTO Country (name) VALUES ('FRANCE'),('GERMANY'),('BELGIUM'),('SWITZERLAND'),('ITALY'),('SPAIN'),('ENGLAND');

CREATE TABLE City
(
    id SERIAL PRIMARY KEY,
    idCountry integer NOT NULL,
    name varchar (50) NOT NULL,
    FOREIGN KEY (idCountry) REFERENCES Country(id)
);

INSERT INTO City (idCountry, name) VALUES
    (1, 'Paris'), (1, 'Marseille'), (1, 'Toulouse'), (1, 'Bordeaux'),
    (2, 'Berlin'), (2, 'Munich'), (2, 'Hambourg'), (2, 'Cologne'),
    (3, 'Liège'), (3, 'Brussels'), (3, 'Bruges'), (3, 'Anvers'),
    (4, 'Zurich'), (4, 'Geneva'), (4, 'Lausanne'), (4, 'Montreux'),
    (5, 'Roma'), (5, 'Venice'), (5, 'Florence'), (5, 'Milan'),
    (6, 'Madrid'), (6, 'Barcelona'), (6, 'Valence'), (6, 'Sevilla'),
    (7, 'London'), (7, 'Manchester'), (7, 'Liverpool'), (7, 'Edimbourg')
;

CREATE TABLE Concert
(
    id SERIAL PRIMARY KEY,
    idBand integer NOT NULL,
    idCity integer NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (idBand) REFERENCES Band(id),
    FOREIGN KEY (idCity) REFERENCES City(id)
);

INSERT INTO Concert (idBand, idCity, date) VALUES
    (1, 1, '2021-02-15'),
    (2, 3, '2021-02-05'),
    (2, 5, '2021-05-10'),
    (3, 1, '2019-03-03'),
    (3, 18, '2021-07-17')
;


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

INSERT INTO Reservation (idConcert, firstName, lastName, email, date) VALUES
    (1, 'Virgile', 'Jallon', 'v.j@gmail.com', '2021-01-01'),
    (1, 'Laurent', 'Lopes', 'laurentlopes@gmail.com', '2021-01-02'),
    (1, 'Benjamin', 'Bonnefoy', 'benji.b@gmail.com', '2021-01-03'),

    (2, 'Julien', 'Loudes', 'jloudes@gmail.com', '2021-02-01'),
    (2, 'Dan', 'Bonix', 'dbonix@gmail.com', '2021-02-02'),

    (3, 'Virgile', 'Jallon', 'v.j@gmail.com', '2021-05-01'),
    (3, 'Laurent', 'Lopes', 'laurentlopes@gmail.com', '2021-05-01'),

    (4, 'Virgile', 'Jallon', 'v.j@gmail.com', '2019-03-01'),
    (4, 'Laura', 'Murzo', 'lauram@gmail.com', '2019-03-02'),

    (5, 'Julia', 'Manne', 'julia.manne@gmail.com', '2021-07-01'),
    (5, 'Laurent', 'Lopes', 'laurentlopes@gmail.com', '2021-07-02')
;
