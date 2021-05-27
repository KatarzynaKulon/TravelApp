DROP TABLE klient CASCADE;
DROP TABLE hotel CASCADE;
DROP TABLE pokoje CASCADE;
DROP TABLE transport CASCADE;
DROP TABLE dostepnosc CASCADE;
DROP TABLE szczegoly_oferty CASCADE;


CREATE TABLE hotel(
	nazwa_hotelu		TEXT PRIMARY KEY,
	lokalizacja		TEXT NOT NULL UNIQUE,
	gwiazdki		INTEGER,
	liczba_pokoi		INTEGER
);


CREATE TABLE klient(
	id_klienta		INT PRIMARY KEY,
	nazwisko		TEXT NOT NULL UNIQUE,
	nr_telefonu		VARCHAR(9),
	nazwa_hotelu		TEXT NOT NULL REFERENCES hotel (nazwa_hotelu) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE pokoje(
	id_pokoju		TEXT PRIMARY KEY,
	nazwa_hotelu		TEXT NOT NULL REFERENCES hotel (nazwa_hotelu) ON DELETE CASCADE ON UPDATE CASCADE,
	iluosobowy		INTEGER CHECK (iluosobowy BETWEEN 1 AND 5),
	balkon			BOOLEAN,
	cena_pokoju		INTEGER NOT NULL
);


CREATE TABLE transport(                                             
	id_transportu		SERIAL PRIMARY KEY,
	śr_transportu		TEXT NOT NULL,	
	lokalizacja		TEXT NOT NULL REFERENCES  hotel (lokalizacja) ON DELETE CASCADE ON UPDATE CASCADE,
	cena_transportu		INTEGER
);

 
CREATE TABLE dostepnosc(
	id_pokoju		TEXT NOT NULL REFERENCES pokoje (id_pokoju) ON DELETE CASCADE ON UPDATE CASCADE,
	poczatek		DATE NOT NULL CHECK (poczatek >= '1/02/2019'),
	koniec			DATE NOT NULL CHECK (koniec > poczatek AND koniec <= '28/02/2019'),
	czy_dostepne		BOOLEAN
);


CREATE TABLE szczegoly_oferty(
	id_oferty		TEXT PRIMARY KEY,
	wyzywienie		TEXT NOT NULL,
	cena			INTEGER NOT NULL
);


CREATE TABLE platnosc(
	id_klienta		INT REFERENCES klient (id_klienta) ON DELETE CASCADE ON UPDATE CASCADE,
	karta_gotowka		TEXT CHECK (karta_gotowka = 'karta' OR karta_gotowka = 'gotowka')
);


INSERT INTO hotel VALUES ('Hilton', 'Londyn', 4, 3);
INSERT INTO hotel VALUES ('Ritz', 'Paryz', 5, 2);
INSERT INTO hotel VALUES ('Plaza', 'Nowy Jork',5, 2);
INSERT INTO hotel VALUES ('Astoria', 'St Petersburg', 6, 2);
INSERT INTO hotel VALUES ('Palms', 'Las Vegas',4, 3);
INSERT INTO hotel VALUES ('Qubus', 'Krakow', 3, 3);	


INSERT INTO klient VALUES (1, 'Walker', 923438102, 'Plaza');
INSERT INTO klient VALUES (2, 'Jansson', 734566111, 'Palms');
INSERT INTO klient VALUES (3, 'Petrov', 997001298, 'Hilton');
INSERT INTO klient VALUES (4, 'Grassi', 883884772, 'Ritz');
INSERT INTO klient VALUES (5, 'Janowski', 993444524, 'Qubus');
INSERT INTO klient VALUES (6, 'Silva', 405405669, 'Astoria');
INSERT INTO klient VALUES (7, 'Jordan', 792066686, 'Plaza');
INSERT INTO klient VALUES (8, 'Presley', 695066686, 'Hilton');
INSERT INTO klient VALUES (9, 'JLo' , 322066686, 'Hilton');
INSERT INTO klient VALUES (10, 'Gates', 129736686, 'Qubus');
INSERT INTO klient VALUES (11, 'Beam', 812066643, 'Astoria');
INSERT INTO klient VALUES (12, 'Daniels', 710266686, 'Hilton');
INSERT INTO klient VALUES (13, 'Guinness', 642012586, 'Ritz');
INSERT INTO klient VALUES (14, 'Potter', 791166606, 'Plaza');
INSERT INTO klient VALUES (15, 'Clouseau', 65842347, 'Ritz');
INSERT INTO klient VALUES (16, 'Hefner', 15869347, 'Palms');


INSERT INTO pokoje VALUES ('1H', 'Hilton', 2, 'n', 200);
INSERT INTO pokoje VALUES ('2H', 'Hilton', 2, 'y', 250);
INSERT INTO pokoje VALUES ('3H', 'Hilton', 3, 'y', 400);
INSERT INTO pokoje VALUES ('1R', 'Ritz', 2, 'n', 200);
INSERT INTO pokoje VALUES ('2R', 'Ritz', 2, 'y', 300);
INSERT INTO pokoje VALUES ('1P', 'Plaza', 1, 'n', 500);
INSERT INTO pokoje VALUES ('2P', 'Plaza', 2, 'y', 600);
INSERT INTO pokoje VALUES ('1A', 'Astoria', 2, 'y', 800);
INSERT INTO pokoje VALUES ('2A', 'Astoria', 2, 'n', 700);
INSERT INTO pokoje VALUES ('1Pa', 'Palms', 3, 'n', 800);
INSERT INTO pokoje VALUES ('2Pa', 'Palms', 2, 'y', 800);
INSERT INTO pokoje VALUES ('3Pa', 'Palms', 4, 'y', 1200);
INSERT INTO pokoje VALUES ('1Q', 'Qubus', 2, 'n', 100);
INSERT INTO pokoje VALUES ('2Q', 'Qubus', 2, 'y', 150);
INSERT INTO pokoje VALUES ('3Q', 'Qubus', 5, 'n', 500);


INSERT INTO transport VALUES (1, 'samolot', 'Londyn', 300);
INSERT INTO transport VALUES (2, 'samolot', 'Nowy Jork', 800);
INSERT INTO transport VALUES (3, 'samolot', 'Las Vegas', 1200);
INSERT INTO transport VALUES (4, 'Orient Express', 'Paryz', 300);
INSERT INTO transport VALUES (5, 'Orient Express', 'St Petersburg',600);
INSERT INTO transport VALUES (6, 'autobus', 'Krakow', 100);
INSERT INTO transport VALUES (7, 'autobus', 'Paryz', 200);
INSERT INTO transport VALUES (8, 'autobus', ' Londyn ', 200);
INSERT INTO transport VALUES (9, 'Orient Express', 'Londyn', 350);
INSERT INTO transport VALUES (10, 'samolot', 'Paryz', 200);
INSERT INTO transport VALUES (11, 'samolot', 'St Petersburg', 300);
INSERT INTO transport VALUES (12, 'autobus', 'St Petersburg', 250);
INSERT INTO transport VALUES (13, 'samolot', 'Krakow', 150);

	
INSERT INTO dostepnosc VALUES ('1H', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1H', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1H', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1H', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2H', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2H', '8/2/2019', '14/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2H', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2H', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('3H', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('3H', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('3H', '15/2/2019', '21/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('3H', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1R', '1/2/2019', '7/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1R', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1R', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1R', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2R', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2R', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2R', '15/2/2019', '21/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2R', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1P', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1P', '8/2/2019', '14/2/2019', 'y');	
INSERT INTO dostepnosc VALUES ('1P', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1P', '22/2/2019', '28/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2P', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2P', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2P', '15/2/2019', '21/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2P', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1A', '1/2/2019', '7/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1A', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1A', '15/2/2019', '21/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1A', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2A', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2A', '8/2/2019', '14/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2A', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2A', '22/2/2019', '28/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1Pa', '1/2/2019', '7/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1Pa', '8/2/2019', '14/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1Pa', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1Pa', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2Pa', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2Pa', '8/2/2019', '14/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2Pa', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2Pa', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('3Pa', '1/2/2019', '7/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('3Pa', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('3Pa', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('3Pa', '22/2/2019', '28/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1Q', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1Q', '8/2/2019', '14/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('1Q', '15/2/2019', '21/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('1Q', '22/2/2019', '28/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2Q', '1/2/2019', '7/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2Q', '8/2/2019', '14/2/2019', 'n');
INSERT INTO dostepnosc VALUES ('2Q', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('2Q', '22/2/2019', '28/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('3Q', '1/2/2019', '7/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('3Q', '8/2/2019', '14/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('3Q', '15/2/2019', '21/2/2019', 'y');
INSERT INTO dostepnosc VALUES ('3Q', '22/2/2019', '28/2/2019', 'n');


INSERT INTO szczegoly_oferty VALUES ('Hilton280', 'HB', 50);
INSERT INTO szczegoly_oferty VALUES ('Hilton281', 'BB', 75);
INSERT INTO szczegoly_oferty VALUES ('Hilton282', 'FB',100);
INSERT INTO szczegoly_oferty VALUES ('Hilton283', 'ALL INC', 175);
INSERT INTO szczegoly_oferty VALUES ('Ritz710', 'HB', 100);
INSERT INTO szczegoly_oferty VALUES ('Ritz711', 'BB', 225);
INSERT INTO szczegoly_oferty VALUES ('Ritz712', 'FB', 300);
INSERT INTO szczegoly_oferty VALUES ('Ritz713', 'ALL INC', 425);
INSERT INTO szczegoly_oferty VALUES ('Plaza446', 'HB', 69);
INSERT INTO szczegoly_oferty VALUES ('Plaza447', 'BB', 113);
INSERT INTO szczegoly_oferty VALUES ('Plaza448', 'FB', 146);
INSERT INTO szczegoly_oferty VALUES ('Plaza449', 'ALL INC', 222);
INSERT INTO szczegoly_oferty VALUES ('Astoria500', 'HB', 60);
INSERT INTO szczegoly_oferty VALUES ('Astoria501', 'BB', 100);
INSERT INTO szczegoly_oferty VALUES ('Astoria502', 'FB', 140);
INSERT INTO szczegoly_oferty VALUES ('Astoria503', 'ALL INC', 200);
INSERT INTO szczegoly_oferty VALUES ('Palms660', 'HB', 44);
INSERT INTO szczegoly_oferty VALUES ('Palms661', 'BB', 88);
INSERT INTO szczegoly_oferty VALUES ('Palms662', 'FB', 101);
INSERT INTO szczegoly_oferty VALUES ('Palms663', 'ALL INC', 232);
INSERT INTO szczegoly_oferty VALUES ('Qubus003', 'HB', 21);
INSERT INTO szczegoly_oferty VALUES ('Qubus004', 'BB', 45);
INSERT INTO szczegoly_oferty VALUES ('Qubus005', 'FB', 80);
INSERT INTO szczegoly_oferty VALUES ('Qubus006', 'ALL INC', 120);


INSERT INTO platnosc VALUES (1, 'karta');
INSERT INTO platnosc VALUES (2, 'karta');
INSERT INTO platnosc VALUES (3, 'karta');
INSERT INTO platnosc VALUES (4, 'gotowka');
INSERT INTO platnosc VALUES (5, 'gotowka');
INSERT INTO platnosc VALUES (6, 'karta');
INSERT INTO platnosc VALUES (7, 'gotowka');
INSERT INTO platnosc VALUES (8, 'karta');
INSERT INTO platnosc VALUES (9, 'karta');
INSERT INTO platnosc VALUES (10, 'gotowka');
INSERT INTO platnosc VALUES (11, 'gotowka');
INSERT INTO platnosc VALUES (12, 'karta');
INSERT INTO platnosc VALUES (13, 'karta');
INSERT INTO platnosc VALUES (14, 'gotowka');
INSERT INTO platnosc VALUES (15, 'karta');
INSERT INTO platnosc VALUES (16, 'gotowka');





