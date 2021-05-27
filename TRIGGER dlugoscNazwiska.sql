CREATE OR REPLACE FUNCTION dlugoscNazwiska() RETURNS TRIGGER AS $$
BEGIN
IF (LENGTH(NEW.nazwisko) < 3 )
THEN RAISE EXCEPTION 'Nazwisko jest za krótkie';
END IF ;
RETURN NEW;
END 
$$LANGUAGE plpgsql;

CREATE TRIGGER dlugoscNazwiskaTrigger 
BEFORE INSERT OR UPDATE OF nazwisko ON klient
FOR EACH ROW  EXECUTE PROCEDURE dlugoscNazwiska();
