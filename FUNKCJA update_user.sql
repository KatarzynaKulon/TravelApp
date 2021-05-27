CREATE OR REPLACE FUNCTION update_user (podaj_id_klienta INTEGER, nowe_nazwisko TEXT, nowy_nr_telefonu CHARACTER VARYING,nowy_hotel TEXT)
RETURNS TEXT AS $$
BEGIN 
UPDATE klient 
SET nazwisko=nowe_nazwisko,
nr_telefonu=nowy_nr_telefonu,
nazwa_hotelu=nowy_hotel
WHERE klient.id_klienta=podaj_id_klienta;
RETURN 'Zaktualizowano informacje';
END; 
$$LANGUAGE plpgsql;


