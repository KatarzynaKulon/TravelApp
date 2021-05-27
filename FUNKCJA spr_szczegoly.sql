CREATE OR REPLACE FUNCTION spr_szczegoly(nazwa_hotelu TEXT)
RETURNS TABLE (id_oferty TEXT, wyzywienie TEXT, cena INTEGER)
AS $$
BEGIN
 RETURN QUERY SELECT szczegoly_oferty.id_oferty, szczegoly_oferty.wyzywienie, szczegoly_oferty.cena
 FROM szczegoly_oferty
 WHERE szczegoly_oferty.id_oferty LIKE nazwa_hotelu;
END; $$
LANGUAGE plpgsql;

-- żeby wywołać trzeba wpisac spr_szczegoly('Hilton%')
