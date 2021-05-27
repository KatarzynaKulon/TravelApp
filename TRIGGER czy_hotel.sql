CREATE OR REPLACE FUNCTION czy_hotel() RETURNS TRIGGER AS $$
BEGIN
IF (NEW.nazwa_hotelu) NOT IN (SELECT nazwa_hotelu FROM hotel)
THEN RAISE EXCEPTION 'Nie ma takiego hotelu w bazie.';
END IF ;
RETURN NEW;
END 
$$LANGUAGE plpgsql;

CREATE TRIGGER czy_hotelTrigger 
BEFORE INSERT OR UPDATE OF nazwa_hotelu ON klient
FOR EACH ROW  EXECUTE PROCEDURE czy_hotel();
