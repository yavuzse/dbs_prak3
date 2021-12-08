CREATE TABLE abteilung(
    anr int PRIMARY KEY,
    name varchar(30)
);

CREATE TABLE person(
    pnr int PRIMARY KEY,
    name varchar(30),
    vorname varchar(30),
    abteilungsnr int REFERENCES abteilung(anr),
    gehalt numeric(8,2),
    gueltigAb date
);

CREATE TABLE gehaltshistorie(
    id SERIAL PRIMARY KEY,
    pnr int,
    gehalt numeric(8,2),
    gueltigAb date,
    aenderungsZeit date,
    username varchar(30)
)