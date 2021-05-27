CREATE OR REPLACE FUNCTION spr_dost (data_p DATE, data_k DATE)
RETURNS TABLE (id_pokoju TEXT, nazwa_hotelu TEXT, cena_pokoju INTEGER) AS $$
BEGIN
 RETURN QUERY SELECT id_pokoju, pokoje.nazwa_hotelu, pokoje.cena_pokoju
 FROM pokoje NATURAL JOIN dostepnosc
WHERE poczatek = data_p AND koniec = data_k AND czy_dostepne='y';
END; $$
LANGUAGE plpgsql;

