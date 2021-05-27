CREATE OR REPLACE FUNCTION Nowy_klient (id_klienta INT, nazwisko TEXT, nr_telefonu VARCHAR(9), nazwa_hotelu TEXT)
RETURNS TEXT AS $$
BEGIN
INSERT INTO klient VALUES(id_klienta, nazwisko, nr_telefonu, nazwa_hotelu);
RETURN 'Dodano nowego klienta';
END;
$$LANGUAGE 'plpgsql';

