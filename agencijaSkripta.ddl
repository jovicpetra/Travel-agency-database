-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-01-21 16:17:46 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE agencija CASCADE CONSTRAINTS;

DROP TABLE angazovani_vodic CASCADE CONSTRAINTS;

DROP TABLE aranzman CASCADE CONSTRAINTS;

DROP TABLE ima CASCADE CONSTRAINTS;

DROP TABLE klijent CASCADE CONSTRAINTS;

DROP TABLE kompanija CASCADE CONSTRAINTS;

DROP TABLE kompanija_za_prevoz CASCADE CONSTRAINTS;

DROP TABLE kompanija_za_smjestaj CASCADE CONSTRAINTS;

DROP TABLE koordinator CASCADE CONSTRAINTS;

DROP TABLE posluje CASCADE CONSTRAINTS;

DROP TABLE prevoz CASCADE CONSTRAINTS;

DROP TABLE radnik CASCADE CONSTRAINTS;

DROP TABLE rezervacija CASCADE CONSTRAINTS;

DROP TABLE smjestaj CASCADE CONSTRAINTS;

DROP TABLE vodic CASCADE CONSTRAINTS;

DROP TABLE zakup_prevoza CASCADE CONSTRAINTS;

DROP TABLE zakup_smjestaja CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE agencija (
    naza VARCHAR2(30 CHAR) NOT NULL,
    adra VARCHAR2(50 CHAR),
    brta VARCHAR2(20 CHAR)
);

ALTER TABLE agencija ADD CONSTRAINT agencija_pk PRIMARY KEY ( naza );

CREATE TABLE angazovani_vodic (
    vodicid       INTEGER NOT NULL,
    aranzmanid    INTEGER NOT NULL,
    agencijaid    VARCHAR2(30 CHAR) NOT NULL,
    koordinatorid INTEGER NOT NULL
);

ALTER TABLE angazovani_vodic ADD CONSTRAINT angazovani_vodic_pk PRIMARY KEY ( vodicid,
                                                                              koordinatorid );

CREATE TABLE aranzman (
    idar       INTEGER NOT NULL,
    desar      VARCHAR2(30 CHAR) NOT NULL,
    cnar       FLOAT NOT NULL,
    datpar     DATE NOT NULL,
    datkar     DATE NOT NULL,
    agencijaid VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE aranzman ADD CONSTRAINT aranzman_pk PRIMARY KEY ( idar,
                                                              agencijaid );

CREATE TABLE ima (
    agencijaid VARCHAR2(30 CHAR) NOT NULL,
    klijentid  INTEGER NOT NULL
);

ALTER TABLE ima ADD CONSTRAINT ima_pk PRIMARY KEY ( agencijaid,
                                                    klijentid );

CREATE TABLE klijent (
    jmbgkl INTEGER NOT NULL,
    imekl  VARCHAR2(20 CHAR) NOT NULL,
    przkl  VARCHAR2(20 CHAR) NOT NULL,
    brtkl  VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE klijent ADD CONSTRAINT klijent_pk PRIMARY KEY ( jmbgkl );

CREATE TABLE kompanija (
    nazk     VARCHAR2(30 CHAR) NOT NULL,
    adrk     VARCHAR2(50 CHAR),
    brtk     VARCHAR2(20 CHAR),
    tipk     VARCHAR2(21) NOT NULL,
    glavnaid VARCHAR2(30 CHAR)
);

ALTER TABLE kompanija
    ADD CONSTRAINT ch_inh_kompanija CHECK ( tipk IN ( 'Kompanija', 'Kompanija_za_prevoz', 'Kompanija_za_smjestaj' ) );

ALTER TABLE kompanija ADD CONSTRAINT kompanija_pk PRIMARY KEY ( nazk );

CREATE TABLE kompanija_za_prevoz (
    nazk VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE kompanija_za_prevoz ADD CONSTRAINT kompanija_za_prevoz_pk PRIMARY KEY ( nazk );

CREATE TABLE kompanija_za_smjestaj (
    nazk VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE kompanija_za_smjestaj ADD CONSTRAINT kompanija_za_smjestaj_pk PRIMARY KEY ( nazk );

CREATE TABLE koordinator (
    jmbgrad INTEGER NOT NULL
);

ALTER TABLE koordinator ADD CONSTRAINT koordinator_pk PRIMARY KEY ( jmbgrad );

CREATE TABLE posluje (
    agencijaid  VARCHAR2(30 CHAR) NOT NULL,
    kompanijaid VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE posluje ADD CONSTRAINT posluje_pk PRIMARY KEY ( agencijaid,
                                                            kompanijaid );

CREATE TABLE prevoz (
    idpr        INTEGER NOT NULL,
    tippr       VARCHAR2(20 CHAR) NOT NULL,
    cnpr        FLOAT NOT NULL,
    bmpr        INTEGER NOT NULL,
    kompanijaid VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE prevoz ADD CONSTRAINT prevoz_pk PRIMARY KEY ( idpr,
                                                          kompanijaid );

CREATE TABLE radnik (
    jmbgrad    INTEGER NOT NULL,
    imerad     VARCHAR2(20 CHAR) NOT NULL,
    przrad     VARCHAR2(20 CHAR) NOT NULL,
    adrrad     VARCHAR2(50 CHAR),
    pltrad     FLOAT,
    brtrad     VARCHAR2(20 CHAR),
    pozrad     VARCHAR2(15 CHAR) NOT NULL,
    agencijaid VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE radnik
    ADD CONSTRAINT ch_inh_radnik CHECK ( pozrad IN ( 'Koordinator', 'Radnik', 'Vodic' ) );

ALTER TABLE radnik ADD CONSTRAINT radnik_pk PRIMARY KEY ( jmbgrad );

CREATE TABLE rezervacija (
    idrez      INTEGER NOT NULL,
    brsj       INTEGER NOT NULL,
    brso       VARCHAR2(10 CHAR) NOT NULL,
    datrez     DATE,
    klijentid  INTEGER NOT NULL,
    aranzmanid INTEGER NOT NULL,
    agencijaid VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE rezervacija ADD CONSTRAINT rezervacija_pk PRIMARY KEY ( idrez );

CREATE TABLE smjestaj (
    idsm        INTEGER NOT NULL,
    nazsm       VARCHAR2(30 CHAR) NOT NULL,
    tipsm       VARCHAR2(20 CHAR) NOT NULL,
    adrsm       VARCHAR2(50 CHAR) NOT NULL,
    brsj        INTEGER NOT NULL,
    cnsm        FLOAT NOT NULL,
    kompanijaid VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE smjestaj ADD CONSTRAINT smjestaj_pk PRIMARY KEY ( idsm,
                                                              kompanijaid );

CREATE TABLE vodic (
    jmbgrad INTEGER NOT NULL
);

ALTER TABLE vodic ADD CONSTRAINT vodic_pk PRIMARY KEY ( jmbgrad );

CREATE TABLE zakup_prevoza (
    datpzp        DATE NOT NULL,
    datkzp        DATE NOT NULL,
    prevozid      INTEGER NOT NULL,
    kompanijaid   VARCHAR2(30 CHAR) NOT NULL,
    aranzmanid    INTEGER NOT NULL,
    agencijaid    VARCHAR2(30 CHAR) NOT NULL,
    koordinatorid INTEGER NOT NULL
);

ALTER TABLE zakup_prevoza
    ADD CONSTRAINT zakup_prevoza_pk PRIMARY KEY ( prevozid,
                                                  kompanijaid,
                                                  koordinatorid );

CREATE TABLE zakup_smjestaja (
    datpzs        DATE NOT NULL,
    datkzs        DATE NOT NULL,
    smjestajid    INTEGER NOT NULL,
    kompanijaid   VARCHAR2(30 CHAR) NOT NULL,
    aranzmanid    INTEGER NOT NULL,
    agencijaid    VARCHAR2(30 CHAR) NOT NULL,
    koordinatorid INTEGER NOT NULL
);

ALTER TABLE zakup_smjestaja
    ADD CONSTRAINT zakup_smjestaja_pk PRIMARY KEY ( smjestajid,
                                                    kompanijaid,
                                                    koordinatorid );

ALTER TABLE angazovani_vodic
    ADD CONSTRAINT angazovani_vodic_aranzman_fk FOREIGN KEY ( aranzmanid,
                                                              agencijaid )
        REFERENCES aranzman ( idar,
                              agencijaid );

ALTER TABLE angazovani_vodic
    ADD CONSTRAINT angazovani_vodic_koor_fk FOREIGN KEY ( koordinatorid )
        REFERENCES koordinator ( jmbgrad );

ALTER TABLE angazovani_vodic
    ADD CONSTRAINT angazovani_vodic_vodic_fk FOREIGN KEY ( vodicid )
        REFERENCES vodic ( jmbgrad );

ALTER TABLE aranzman
    ADD CONSTRAINT aranzman_agencija_fk FOREIGN KEY ( agencijaid )
        REFERENCES agencija ( naza );

ALTER TABLE ima
    ADD CONSTRAINT ima_agencija_fk FOREIGN KEY ( agencijaid )
        REFERENCES agencija ( naza );

ALTER TABLE ima
    ADD CONSTRAINT ima_klijent_fk FOREIGN KEY ( klijentid )
        REFERENCES klijent ( jmbgkl );

ALTER TABLE kompanija_za_prevoz
    ADD CONSTRAINT kompanija_fk FOREIGN KEY ( nazk )
        REFERENCES kompanija ( nazk );

ALTER TABLE kompanija_za_smjestaj
    ADD CONSTRAINT kompanija_fkv2 FOREIGN KEY ( nazk )
        REFERENCES kompanija ( nazk );

ALTER TABLE kompanija
    ADD CONSTRAINT kompanija_kompanija_fk FOREIGN KEY ( glavnaid )
        REFERENCES kompanija ( nazk );

ALTER TABLE koordinator
    ADD CONSTRAINT koordinator_radnik_fk FOREIGN KEY ( jmbgrad )
        REFERENCES radnik ( jmbgrad );

ALTER TABLE posluje
    ADD CONSTRAINT posluje_agencija_fk FOREIGN KEY ( agencijaid )
        REFERENCES agencija ( naza );

ALTER TABLE posluje
    ADD CONSTRAINT posluje_kompanija_fk FOREIGN KEY ( kompanijaid )
        REFERENCES kompanija ( nazk );

ALTER TABLE prevoz
    ADD CONSTRAINT prevoz_kompanija_fk FOREIGN KEY ( kompanijaid )
        REFERENCES kompanija_za_prevoz ( nazk );

ALTER TABLE radnik
    ADD CONSTRAINT radnik_agencija_fk FOREIGN KEY ( agencijaid )
        REFERENCES agencija ( naza );

ALTER TABLE rezervacija
    ADD CONSTRAINT rezervacija_aranzman_fk FOREIGN KEY ( aranzmanid,
                                                         agencijaid )
        REFERENCES aranzman ( idar,
                              agencijaid );

ALTER TABLE rezervacija
    ADD CONSTRAINT rezervacija_klijent_fk FOREIGN KEY ( klijentid )
        REFERENCES klijent ( jmbgkl );

ALTER TABLE smjestaj
    ADD CONSTRAINT smjestaj_kompanija_fk FOREIGN KEY ( kompanijaid )
        REFERENCES kompanija_za_smjestaj ( nazk );

ALTER TABLE vodic
    ADD CONSTRAINT vodic_radnik_fk FOREIGN KEY ( jmbgrad )
        REFERENCES radnik ( jmbgrad );

ALTER TABLE zakup_prevoza
    ADD CONSTRAINT zakup_prevoza_aranzman_fk FOREIGN KEY ( aranzmanid,
                                                           agencijaid )
        REFERENCES aranzman ( idar,
                              agencijaid );

ALTER TABLE zakup_prevoza
    ADD CONSTRAINT zakup_prevoza_koordinator_fk FOREIGN KEY ( koordinatorid )
        REFERENCES koordinator ( jmbgrad );

ALTER TABLE zakup_prevoza
    ADD CONSTRAINT zakup_prevoza_prevoz_fk FOREIGN KEY ( prevozid,
                                                         kompanijaid )
        REFERENCES prevoz ( idpr,
                            kompanijaid );

ALTER TABLE zakup_smjestaja
    ADD CONSTRAINT zakup_smjestaja_aranzman_fk FOREIGN KEY ( aranzmanid,
                                                             agencijaid )
        REFERENCES aranzman ( idar,
                              agencijaid );

ALTER TABLE zakup_smjestaja
    ADD CONSTRAINT zakup_smjestaja_koordinator_fk FOREIGN KEY ( koordinatorid )
        REFERENCES koordinator ( jmbgrad );

ALTER TABLE zakup_smjestaja
    ADD CONSTRAINT zakup_smjestaja_smjestaj_fk FOREIGN KEY ( smjestajid,
                                                             kompanijaid )
        REFERENCES smjestaj ( idsm,
                              kompanijaid );
                              
INSERT INTO agencija(naza, adra, brta) VALUES ('Modena Travel', 'Ulica Modene, Novi Sad', '021/539-333');
INSERT INTO klijent(jmbgkl, imekl, przkl, brtkl) VALUES (2201999185862, 'Petra', 'Jovic', '021/539-444');
INSERT INTO klijent(jmbgkl, imekl, przkl, brtkl) VALUES (2201999185863, 'Milan', 'Jovic', '021/539-555');
INSERT INTO radnik(jmbgrad, imerad, przrad, adrrad, pltrad, brtrad, pozrad, agencijaid) VALUES (1101988185863, 'Miljana', 'Marjanovic', 'Dunavska 11, Novi Sad', 50000.0, '021/500-555', 'Koordinator', 'Modena Travel');
INSERT INTO koordinator(jmbgrad) VALUES (1101988185863);
INSERT INTO radnik(jmbgrad, imerad, przrad, adrrad, pltrad, brtrad, pozrad, agencijaid) VALUES (1101988185909, 'Andjela', 'Djuric', 'Dr Sime Milosevica 10, Novi Sad', 90000.0, '021/500-555', 'Koordinator', 'Modena Travel');
INSERT INTO koordinator(jmbgrad) VALUES (1101988185909);
INSERT INTO radnik(jmbgrad, imerad, przrad, adrrad, pltrad, brtrad, pozrad, agencijaid) VALUES (0501998185909, 'Luka', 'Tanasijevic', 'Dr Sime Milosevica 10, Novi Sad', 90000.0, '021/500-555', 'Vodic', 'Modena Travel');
INSERT INTO vodic(jmbgrad) VALUES (0501998185909);
INSERT INTO radnik(jmbgrad, imerad, przrad, adrrad, pltrad, brtrad, pozrad, agencijaid) VALUES (1801998185323, 'Zarko', 'Nedeljkov', 'Dr Sime Milosevica 10, Novi Sad', 90000.0, '021/809-555', 'Vodic', 'Modena Travel');
INSERT INTO vodic(jmbgrad) VALUES (1801998185323);
INSERT INTO aranzman(idar, desar, cnar, datpar, datkar, agencijaid) VALUES (1, 'Turska', 40000.0, date '2022-03-01', date '2022-03-09', 'Modena Travel');
INSERT INTO aranzman(idar, desar, cnar, datpar, datkar, agencijaid) VALUES (2, 'Grcka', 60000.0, date '2022-08-01', date '2022-08-09', 'Modena Travel');
INSERT INTO aranzman(idar, desar, cnar, datpar, datkar, agencijaid) VALUES (3, 'Spanija', 80000.0, date '2022-07-01', date '2022-07-15', 'Modena Travel');
INSERT INTO ima(agencijaid, klijentid) VALUES ('Modena Travel', 2201999185862);
INSERT INTO ima(agencijaid, klijentid) VALUES ('Modena Travel', 2201999185863);
INSERT INTO rezervacija(idrez, brsj, brso, datrez, klijentid, aranzmanid, agencijaid) VALUES (1, 22, 'S-5', date '2022-01-01', 2201999185862, 1, 'Modena Travel');
INSERT INTO rezervacija(idrez, brsj, brso, datrez, klijentid, aranzmanid, agencijaid) VALUES (2, 10, 'S-22', date '2022-01-01', 2201999185862, 3, 'Modena Travel');
INSERT INTO rezervacija(idrez, brsj, brso, datrez, klijentid, aranzmanid, agencijaid) VALUES (3, 55, 'S-2', date '2022-01-01', 2201999185863, 3, 'Modena Travel');
INSERT INTO rezervacija(idrez, brsj, brso, datrez, klijentid, aranzmanid, agencijaid) VALUES (4, 10, 'S-22', date '2022-01-01', 2201999185862, 3, 'Modena Travel');
INSERT INTO kompanija(nazk, adrk, brtk, tipk) VALUES ('Sirmium', 'Draginje Niksic, Sremska Mitrovica', '021/500-789', 'Kompanija_za_prevoz');
INSERT INTO  kompanija_za_prevoz(nazk) VALUES ('Sirmium');
INSERT INTO kompanija(nazk, adrk, brtk, tipk) VALUES ('Lasta', 'Beograd', '021/765-789', 'Kompanija_za_prevoz');
INSERT INTO  kompanija_za_prevoz(nazk) VALUES ('Lasta');
INSERT INTO kompanija(nazk, adrk, brtk, tipk) VALUES ('Booking', 'Beograd', '021/000-789', 'Kompanija_za_smjestaj');
INSERT INTO  kompanija_za_smjestaj(nazk) VALUES ('Booking');
INSERT INTO kompanija(nazk, adrk, brtk, tipk) VALUES ('AirBnb', 'Novi Sad', '021/000-789', 'Kompanija_za_smjestaj');
INSERT INTO  kompanija_za_smjestaj(nazk) VALUES ('AirBnb');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (1, 'bus', 7000.0, 100, 'Sirmium');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (2, 'bus', 7000.0, 150, 'Sirmium');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (3, 'bus', 5000.0, 100, 'Sirmium');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (1, 'bus', 7000.0, 100, 'Lasta');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (2, 'bus', 7000.0, 150, 'Lasta');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (3, 'bus', 5000.0, 100, 'Lasta');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (4, 'bus', 5500.0, 90, 'Lasta');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (5, 'bus', 9000.0, 60, 'Lasta');
INSERT INTO prevoz(idpr, tippr, cnpr, bmpr, kompanijaid) VALUES (6, 'bus', 3000.0, 200, 'Lasta');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (1, 'Akra', 'Hotel', 'Lara Yolu Muratpa?a, Antalya', 500, 10000, 'Booking');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (2, 'Porto Bello', 'Hote', 'Liman Mah.1. Sok. Konyaalti, Antalya', 500, 20000, 'Booking');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (1, 'Pegasos Royal', 'Hotel', 'AirBnb, Antalya', 500, 30000, 'AirBnb');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (3, 'Relais', 'Luxury Villas', 'Halkidiki', 500, 30000, 'Booking');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (2, 'Liotopu', 'Hotel', 'Halkidiki', 500, 20000, 'AirBnb');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (3, 'Stratos', 'Hotel', 'Halkidiki', 500, 10000, 'AirBnb');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (4, 'Lloret Ramblas', 'Hotel', 'Barcelona', 500, 30000, 'Booking');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (5, 'Condal', 'Hotel', 'Barcelona', 500, 20000, 'Booking');
INSERT INTO smjestaj(idsm, nazsm, tipsm, adrsm, brsj, cnsm, kompanijaid) VALUES (4, 'Oasis', 'Hotel', 'Barcelona', 500, 140000, 'AirBnb');
INSERT INTO posluje(agencijaid, kompanijaid) VALUES ('Modena Travel', 'Sirmium');
INSERT INTO posluje(agencijaid, kompanijaid) VALUES ('Modena Travel', 'Lasta');
INSERT INTO posluje(agencijaid, kompanijaid) VALUES ('Modena Travel', 'Booking');
INSERT INTO posluje(agencijaid, kompanijaid) VALUES ('Modena Travel', 'AirBnb');
INSERT INTO zakup_prevoza(datpzp, datkzp, prevozid, kompanijaid, aranzmanid, agencijaid, koordinatorid) VALUES (date '2022-03-01', date '2022-03-09', 1, 'Sirmium', 1, 'Modena Travel', 1101988185863);
INSERT INTO zakup_prevoza(datpzp, datkzp, prevozid, kompanijaid, aranzmanid, agencijaid, koordinatorid) VALUES (date '2022-08-01', date '2022-08-09', 2, 'Lasta', 2, 'Modena Travel', 1101988185863);
INSERT INTO zakup_prevoza(datpzp, datkzp, prevozid, kompanijaid, aranzmanid, agencijaid, koordinatorid) VALUES (date '2022-07-01', date '2022-07-15', 6, 'Lasta', 3, 'Modena Travel', 1101988185863);
INSERT INTO zakup_smjestaja(datpzs, datkzs, smjestajid, kompanijaid, aranzmanid, agencijaid, koordinatorid) VALUES (date '2022-03-01', date '2022-03-09', 1, 'Booking', 1, 'Modena Travel', 1101988185863);
INSERT INTO zakup_smjestaja(datpzs, datkzs, smjestajid, kompanijaid, aranzmanid, agencijaid, koordinatorid) VALUES (date '2022-08-01', date '2022-08-09', 3, 'Booking', 2, 'Modena Travel', 1101988185863);
INSERT INTO zakup_smjestaja(datpzs, datkzs, smjestajid, kompanijaid, aranzmanid, agencijaid, koordinatorid) VALUES (date '2022-07-01', date '2022-07-15', 4, 'AirBnb', 3, 'Modena Travel', 1101988185863);
INSERT INTO angazovani_vodic(vodicid, aranzmanid, agencijaid, koordinatorid) VALUES (0501998185909, 1, 'Modena Travel', 1101988185909);
INSERT INTO angazovani_vodic(vodicid, aranzmanid, agencijaid, koordinatorid) VALUES (0501998185909, 2, 'Modena Travel', 1101988185909);
INSERT INTO angazovani_vodic(vodicid, aranzmanid, agencijaid, koordinatorid) VALUES (1801998185323, 3, 'Modena Travel', 1101988185909);

CREATE OR REPLACE VIEW Putovanje as 
select desar, count(idrez) as brrez, datpar, datkar, tippr, nazsm, sum(cnar) as zarada
from rezervacija, aranzman, angazovani_vodic, zakup_smjestaja, zakup_prevoza, smjestaj, prevoz
where rezervacija.aranzmanid = aranzman.idar and rezervacija.agencijaid = aranzman.agencijaid
    and angazovani_vodic.aranzmanid = aranzman.idar and angazovani_vodic.agencijaid = aranzman.agencijaid
    and zakup_smjestaja.aranzmanid = aranzman.idar and zakup_smjestaja.agencijaid = aranzman.agencijaid
    and zakup_prevoza.aranzmanid = aranzman.idar and zakup_prevoza.agencijaid = aranzman.agencijaid
    and smjestaj.idsm = zakup_smjestaja.smjestajid and prevoz.idpr = zakup_prevoza.prevozid
    and smjestaj.kompanijaid = zakup_smjestaja.kompanijaid and prevoz.kompanijaid = zakup_prevoza.kompanijaid
    and datpar > date '2022-01-01'
group by  desar, datpar, datkar, tippr, nazsm
having sum(cnar) > 20000
order by desar asc;

select * from Putovanje;

select distinct imerad, przrad 
from radnik
where jmbgrad in
(select koordinatorid from zakup_prevoza where aranzmanid in
(select idar from aranzman where cnar between 4000 and 70000));

CREATE OR REPLACE TRIGGER arc_fkar_kompanija_za_smjestaj BEFORE
    INSERT OR UPDATE OF nazk ON kompanija_za_smjestaj
    FOR EACH ROW
DECLARE
    d VARCHAR2(21);
BEGIN
    SELECT
        a.tipk
    INTO d
    FROM
        kompanija a
    WHERE
        a.nazk = :new.nazk;

    IF ( d IS NULL OR d <> 'Kompanija_za_smjestaj' ) THEN
        raise_application_error(
                               -20223,
                               'FK Kompanija_FKv2 in Table Kompanija_za_smjestaj violates Arc constraint on Table Kompanija - discriminator column Tipk doesn''t have value ''Kompanija_za_smjestaj'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc__kompanija_za_prevoz BEFORE
    INSERT OR UPDATE OF nazk ON kompanija_za_prevoz
    FOR EACH ROW
DECLARE
    d VARCHAR2(21);
BEGIN
    SELECT
        a.tipk
    INTO d
    FROM
        kompanija a
    WHERE
        a.nazk = :new.nazk;

    IF ( d IS NULL OR d <> 'Kompanija_za_prevoz' ) THEN
        raise_application_error(
                               -20223,
                               'FK Kompanija_FK in Table Kompanija_za_prevoz violates Arc constraint on Table Kompanija - discriminator column Tipk doesn''t have value ''Kompanija_za_prevoz'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_vodic BEFORE
    INSERT OR UPDATE OF jmbgrad ON vodic
    FOR EACH ROW
DECLARE
    d VARCHAR2(15 CHAR);
BEGIN
    SELECT
        a.pozrad
    INTO d
    FROM
        radnik a
    WHERE
        a.jmbgrad = :new.jmbgrad;

    IF ( d IS NULL OR d <> 'Vodic' ) THEN
        raise_application_error(
                               -20223,
                               'FK Vodic_Radnik_FK in Table Vodic violates Arc constraint on Table Radnik - discriminator column Pozrad doesn''t have value ''Vodic'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_koordinator BEFORE
    INSERT OR UPDATE OF jmbgrad ON koordinator
    FOR EACH ROW
DECLARE
    d VARCHAR2(15 CHAR);
BEGIN
    SELECT
        a.pozrad
    INTO d
    FROM
        radnik a
    WHERE
        a.jmbgrad = :new.jmbgrad;

    IF ( d IS NULL OR d <> 'Koordinator' ) THEN
        raise_application_error(
                               -20223,
                               'FK Koordinator_Radnik_FK in Table Koordinator violates Arc constraint on Table Radnik - discriminator column Pozrad doesn''t have value ''Koordinator'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             43
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           4
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
