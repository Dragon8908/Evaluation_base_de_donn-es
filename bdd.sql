CREATE DATABASE IF NOT EXISTS bdd_cinema DEFAULT CHARACTER SET = 'utf8mb4';
USE bdd_cinema;

CREATE TABLE IF NOT EXISTS Admins(
    id_admin INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    mot_passe VARCHAR(50) NOT NULL
);

-- Les complexes avc un admin qui gère chaque complexe
CREATE TABLE IF NOT EXISTS Complexe(
    id_complexe INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    id_admin INt NOT NULL,
    CONSTRAINT fk_id_admin FOREIGN KEY (id_admin) REFERENCES Admins(id_admin)  
);

CREATE TABLE IF NOT EXISTS Client(
    id_client INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    etudiant INT(1)
);

CREATE TABLE IF NOT EXISTS Film(
    id_film INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(50) NOT NULL,
    duree TIME NOT NULL,
    genre VARCHAR(50) NOT NULL,
    realisateur VARCHAR(100) NOT NULL,
    annee INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Salle(
    id_salle INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nb_places INT NOT NULL,
    places_restantes INT NOT NULL,
    id_complexe INT NOT NULL,
    CONSTRAINT fk_id_complexe FOREIGN KEY (id_complexe) REFERENCES Complexe(id_complexe)
);

CREATE TABLE IF NOT EXISTS Prix(
    id_prix INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    categorie VARCHAR(30) NOT NULL,
    prix FLOAT NOT NULL
);

-- Une séance pour un film et à quelle heure le film passe
CREATE TABLE IF NOT EXISTS Seance(
    id_seance INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_seance VARCHAR(100) NOT NULL,
    id_salle INT NOT NULL,
    id_film INT NOT NULL,
    CONSTRAINT fk_id_salle FOREIGN KEY (id_salle) REFERENCES Salle(id_salle),
    CONSTRAINT fk_id_film FOREIGN KEY (id_film) REFERENCES Film(id_film)
);

-- Ticket avec le prix, la séance et le nom du client dessus
CREATE TABLE IF NOT EXISTS Ticket(
    id_ticket INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_client INT NOT NULL,
    id_seance INT NOT NULL,
    id_prix INT NOT NULL,
    CONSTRAINT fk_id_client FOREIGN KEY (id_client) REFERENCES Client(id_client),
    CONSTRAINT fk_id_seance FOREIGN KEY (id_seance) REFERENCES Seance(id_seance),
    CONSTRAINT fk_id_prix FOREIGN KEY (id_prix) REFERENCES Prix(id_prix)
);

INSERT INTO Admins (nom, prenom, email, mot_passe) VALUES ('Dupont', 'Jean', 'jeandupont@cinema.fr', MD5('Jesuislechefadmin'));
INSERT INTO Admins (nom, prenom, email, mot_passe) VALUES ('Doe', 'John', 'johndoe@cinema.fr', MD5('Jesuislesouschefadmin'));
INSERT INTO Admins (nom, prenom, email, mot_passe) VALUES ('Doe', 'Jane', 'janedoe@cinema.fr', MD5('Soeurdusouyschefadmin'));

INSERT INTO Complexe (nom, adresse, ville, id_admin) VALUES ('Premier cinéma', '1 rue du cinéma', 'Cinémaland', 1);
INSERT INTO Complexe (nom, adresse, ville, id_admin) VALUES ('Deuxième cinéma', '2 rue du cinéma', 'Cinémaland', 2);
INSERT INTO Complexe (nom, adresse, ville, id_admin) VALUES ('Troisème cinéma', '3 rue du cinéma', 'Cinémaland', 3);

INSERT INTO Client (nom, prenom, age, etudiant) VALUES ('Michel', 'George', 50, 0);
INSERT INTO Client (nom, prenom, age, etudiant) VALUES ('Lacazette', 'Tom', 12, 0);
INSERT INTO Client (nom, prenom, age, etudiant) VALUES ('Dupond', 'Maxine', 23, 1);
INSERT INTO Client (nom, prenom, age, etudiant) VALUES ('Westwood', 'Flint', 92, 0);
INSERT INTO Client (nom, prenom, age, etudiant) VALUES ('Ledernier', 'Noémie', 19, 1);

INSERT INTO Film (titre, duree, genre, realisateur, annee) VALUES ('Avatar', '02:42:00', 'Aventure/SF', 'James Cameron', 2009);
INSERT INTO Film (titre, duree, genre, realisateur, annee) VALUES ('Le Parrain', '02:55:00', 'Policier/Mafia', 'Francis Ford Coppola', 1972);
INSERT INTO Film (titre, duree, genre, realisateur, annee) VALUES ('Alien, le huitième passager', '01:56:00', 'Horreur/SF', 'Ridley Scott', 1979);
INSERT INTO Film (titre, duree, genre, realisateur, annee) VALUES ('Avengers: Infinity war', '02:36:00', 'Action/Fantastique', 'Fréres Russo', 2018);
INSERT INTO Film (titre, duree, genre, realisateur, annee) VALUES ('Les Evadés', '02:22:00', 'Drame', 'Frank Darabont', 1995);

INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (200, 129, 1);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (300, 23, 1);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (250, 6, 1);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (100, 54, 2);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (50, 7, 2);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (150, 67, 2);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (400, 234, 3);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (350, 59, 3);
INSERT INTO Salle (nb_places, places_restantes, id_complexe) VALUES (150, 149, 3);

INSERT INTO Prix (categorie, prix) VALUES ('Plein tarif', 9.20);
INSERT INTO Prix (categorie, prix) VALUES ('Etudiant', 7.60);
INSERT INTO Prix (categorie, prix) VALUES ('Moins de 14 ans', 5.90);

INSERT INTO Seance (date_seance, id_salle, id_film) VALUES (' 14 Mars à 16h00', 1, 3);
INSERT INTO Seance (date_seance, id_salle, id_film) VALUES (' 30 Mars à 10h00', 7, 1);
INSERT INTO Seance (date_seance, id_salle, id_film) VALUES (' 10 Mars à 19h00', 4, 2);
INSERT INTO Seance (date_seance, id_salle, id_film) VALUES (' 2 Avril à 08h00', 6, 5);
INSERT INTO Seance (date_seance, id_salle, id_film) VALUES (' 24 Mars à 22h00', 9, 4);

INSERT INTO Ticket(id_client, id_seance, id_prix) VALUES (1, 4, 1);
INSERT INTO Ticket(id_client, id_seance, id_prix) VALUES (2, 5, 3);
INSERT INTO Ticket(id_client, id_seance, id_prix) VALUES (3, 1, 2);
INSERT INTO Ticket(id_client, id_seance, id_prix) VALUES (4, 2, 1);
INSERT INTO Ticket(id_client, id_seance, id_prix) VALUES (5, 3, 2);
