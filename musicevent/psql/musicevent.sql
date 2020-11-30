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

INSERT INTO MusicType (name) VALUES ('Metal'), ('Rock'), ('Rap'), ('Electro'), ('Alternative');

CREATE TABLE Band
(
    id SERIAL PRIMARY KEY,
    idMusicType integer NOT NULL,
    name varchar (50) NOT NULL,
    mediaUrl text DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    FOREIGN KEY (idMusicType) REFERENCES MusicType(id)
);

--Groupes de metal
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'POWERWOLF','https://images-na.ssl-images-amazon.com/images/I/91Vc6ZS1kQL._SL1500_.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'SABATON','https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515371_10629.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'System Of A Down','https://www.lagrosseradio.com/webzine/images/15743.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'As I Lay Dying','https://www.rockurlife.net/wp-content/uploads/2019/09/ShapedByFIre.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'Metallica','https://www.clique.tv/wp-content/uploads/2017/01/Metallica.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'Iron Maiden','https://images-na.ssl-images-amazon.com/images/I/81Ih%2B-GSyUL._SL1300_.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (1,'Rammstein','https://images-na.ssl-images-amazon.com/images/I/71qEnlTmAkL._SL1123_.jpg');

--Groupes de rock
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (2,'ACDC','https://i.ytimg.com/vi/9FzC5881E4s/maxresdefault.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (2,'Red Hot Chili Peppers','https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515368_10599.jpg');

--Alternative
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (5,'TOOOD','https://www.tasteofindie.com/wp-content/uploads/2014/11/TOOOD_II_069.jpg');

--Rappeurs
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (3,'Eminem','https://lecanalauditif.ca/wp-content/uploads/2018/01/Eminem.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (3,'Drake','https://i1.wp.com/views.fr/wp-content/uploads/2019/10/5c677b7bfc2f696abf2e2d928301bb44.1000x1000x1.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (3,'Travis Scott','https://www.thebackpackerz.com/wp-content/uploads/2018/08/home-clique-travis-scott-astroworld.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (3,'6ix9ine','https://i.pinimg.com/originals/83/2e/d6/832ed62c222fc5acb88ba2640e5dcb68.jpg');

--Electro
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'Daft Punk','https://cdn-s-www.estrepublicain.fr/images/69254D95-AD72-4908-9950-BFCF4041D356/NW_raw/capture-d-ecran-de-la-page-d-accueil-www-daftpunk-com-1361951190.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'Deadmau5','https://www.thefamouspeople.com/profiles/images/deadmau5-2.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'Tiësto','https://m.media-amazon.com/images/I/41iYHdodZOL._SL1000_.jpg');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'W&W','https://images.squarespace-cdn.com/content/v1/52caf22ee4b05977ab043ee9/1464821925219-7DBGX5TINN3FXJL1KUWL/ke17ZwdGBToddI8pDm48kNZu818u8d5rYnrob_pZCjJ7gQa3H78H3Y0txjaiv_0foACs49-HBkG_F4C3fTziO48P4ND6591eyixB1seuwXaplUIB77utV0SH3QLyqo6UOqpeNLcJ80NK65_fV7S1UWwHt-UECQkRgRXE78GKwNY_bpKTyGh4ZrtKcaQ0Hi6GTaIpBKTr91CW8Hu-LnUQUQ/Screen+Shot+2015-06-15+at+11.40.28+AM.png');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'KSHMR','https://yt3.ggpht.com/ytc/AAUvwnhybXdFqOz-Gd9FLc8uYq4ln0XFqq_690tupk0flw=s900-c-k-c0x00ffffff-no-rj');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'Hardwell','https://yt3.ggpht.com/ytc/AAUvwngq-_fI1w_1xYn-XUNuErlY-YHwCiddYqfXDfMWPQ=s900-c-k-c0x00ffffff-no-rj');
INSERT INTO Band (idMusicType, name, mediaUrl) VALUES (4,'Marshmello','https://cdns-images.dzcdn.net/images/artist/1717336c715acaf7600b1dc79b4e2a1c/264x264.jpg');

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
    (2, 'Berlin'), (2, 'Munich'), (2, 'Hamburg'), (2, 'Cologne'),
    (3, 'Liège'), (3, 'Brussels'), (3, 'Bruges'), (3, 'Anvers'),
    (4, 'Zurich'), (4, 'Geneva'), (4, 'Lausanne'), (4, 'Montreux'),
    (5, 'Roma'), (5, 'Venice'), (5, 'Florence'), (5, 'Milan'),
    (6, 'Madrid'), (6, 'Barcelona'), (6, 'Valencia'), (6, 'Seville'),
    (7, 'London'), (7, 'Manchester'), (7, 'Liverpool'), (7, 'Edinburgh')
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
-- 28 villes et 21 artistes
    (1, 1, '2020-02-15'),
    (2, 3, '2020-02-05'),
    (2, 5, '2020-05-10'),
    (3, 1, '2019-03-03'),
    (3, 18, '2020-07-17'),
    
--AJout de concerts 29/11 par val    
    (21,15,'2020-12-18'),
    (10,14,'2020-12-25'),
    (18,17,'2021-01-01'),
    (10,3,'2021-01-28'),
    (17,9,'2021-01-29'),
    (6,25,'2021-02-20'),
    (4,16,'2021-02-25'),
    (18,7,'2021-02-26'),
    (5,20,'2021-02-27'),
    (17,26,'2021-04-29'),
    (11,25,'2021-05-06'),
    (13,7,'2021-05-21'),
    (18,3,'2021-05-29'),
    (20,19,'2021-06-05'),
    (16,26,'2021-07-02'),
    (21,15,'2021-07-22'),
    (3,11,'2021-08-13'),
    (13,12,'2021-08-26'),
    (4,5,'2021-08-27'),
    (13,9,'2021-09-10'),
    (15,18,'2021-09-24'),
    (7,27,'2021-11-04'),
    (16,17,'2021-12-10'),
    (19,23,'2021-12-11'),
    (10,7,'2021-12-30'),
    
    (14,24,'2020-12-19'),
    (17,26,'2020-12-24'),
    (7,18,'2020-12-31'),
    (1,5,'2021-01-09'),
    (6,14,'2021-01-22'),
    (9,9,'2021-01-23'),
    (13,3,'2021-03-04'),
    (8,15,'2021-03-06'),
    (5,26,'2021-03-20'),
    (2,19,'2021-03-25'),
    (12,11,'2021-04-01'),
    (4,17,'2021-05-07'),
    (16,5,'2021-06-18'),
    (20,1,'2021-08-14'),
    (2,20,'2021-08-26'),
    (19,2,'2021-08-27'),
    (18,5,'2021-09-10'),
    (8,18,'2021-09-24'),
    (10,7,'2021-10-01'),
    (19,15,'2021-10-29'),
    (9,2,'2021-10-30'),
    (1,4,'2021-11-19'),
    (5,8,'2021-12-03'),
    (10,20,'2021-12-09'),
    (13,28,'2021-12-23')
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
    (5, 'Virgile', 'Jallon', 'v.j@gmail.com', '2020-01-01'),
    (13, 'Laurent', 'Lopes', 'laurentlopes@gmail.com', '2020-01-02'),
    (7, 'Benjamin', 'Bonnefoy', 'benji.b@gmail.com', '2020-01-03'),

    (9, 'Julien', 'Loudes', 'jloudes@gmail.com', '2020-02-01'),
    (20, 'Dan', 'Bonix', 'dbonix@gmail.com', '2020-02-02'),

    (17, 'Virgile', 'Jallon', 'v.j@gmail.com', '2020-05-01'),
    (5, 'Laurent', 'Lopes', 'laurentlopes@gmail.com', '2020-05-01'),

    (5, 'Virgile', 'Jallon', 'v.j@gmail.com', '2019-03-01'),
    (14, 'Laura', 'Murzo', 'lauram@gmail.com', '2019-03-02'),

    (18, 'Julia', 'Manne', 'julia.manne@gmail.com', '2020-07-01'),
    (12, 'Laurent', 'Lopes', 'laurentlopes@gmail.com', '2020-07-02')
;
