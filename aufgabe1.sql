CREATE FUNCTION regeln() RETURNS TRIGGER AS
$emp_stamp$
declare
    average      numeric(8, 2);
    person_count int;
begin
    person_count := (SELECT count(*) FROM person WHERE abteilungsnr = NEW.abteilungsnr);
    if person_count > 0 then
        average := (SELECT avg(gehalt) FROM person WHERE abteilungsnr = NEW.abteilungsnr);
        if NEW.gehalt > average * 1.5 then
            raise exception 'GEHALT 50 PROZENT HÖHER ALS DURCHSCHNITT';
        end if;
    end if;

    if OLD.gehalt > NEW.gehalt then
        raise exception 'GEHALT DARF NICHT REDUZIERT WERDEN!';
    end if;

    if NEW.gehalt > OLD.gehalt * 1.2 then
        NEW.gehalt = OLD.gehalt * 1.2;
    end if;

    if NEW.gueltigAb < OLD.gueltigAb then
        raise exception 'GEHALTSAENDERUNGEN DÜRFEN NICHT RÜCKWIRKEND SEIN!';
    end if;

    if OLD is not NULL then
        INSERT INTO gehaltshistorie(pnr, gehalt, gueltigab, aenderungszeit, username)
        VALUES (OLD.pnr, OLD.gehalt, OLD.gueltigab, current_date, current_user);
    end if;

    return new;
end ;
$emp_stamp$ LANGUAGE 'plpgsql';

CREATE TRIGGER regel BEFORE INSERT OR UPDATE ON person FOR EACH ROW EXECUTE PROCEDURE regeln();


