SELECT count(abteilungsnr), a.name FROM person p
    JOIN gehaltshistorie g on g.pnr = p.pnr
    RIGHT JOIN abteilung a on a.anr = p.abteilungsnr
group by a.name;

CREATE VIEW alleGehaelter AS
    SELECT pnr, gehalt, gueltigab FROM person UNION
    SELECT pnr, gehalt, gueltigab FROM gehaltshistorie;

select gehalt, gueltigab from alleGehaelter WHERE pnr = 3 AND gueltigab = '2020-01-01'