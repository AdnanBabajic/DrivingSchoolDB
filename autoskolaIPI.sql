-- --------------------------------------------------------
-- Host:                         .\SQLEXPRESS
-- Server version:               Microsoft SQL Server 2014 - 12.0.2000.8
-- Server OS:                    Windows NT 6.3 <X64> (Build 17763: )
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for autoskolaipi
CREATE DATABASE IF NOT EXISTS "autoskolaipi";
USE "autoskolaipi";

-- Dumping structure for table autoskolaipi.Auto Škola
CREATE TABLE IF NOT EXISTS "Auto Škola" (
	"id_autoskole" INT NOT NULL,
	"naziv_autoskole" VARCHAR(50) NOT NULL DEFAULT '''Auto škola''' COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"mjesto" VARCHAR(30) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"ulica" VARCHAR(30) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"broj_ulice" INT NULL DEFAULT NULL,
	"broj_telefona" VARCHAR(9) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	PRIMARY KEY ("id_autoskole")
);

-- Data exporting was unselected.

-- Dumping structure for procedure autoskolaipi.cas_voznje
DELIMITER //
CREATE PROCEDURE cas_voznje
@id_instruktora INT , @id_prolaznika INT , @broj_casa INT , @datum VARCHAR(10), @vrijeme VARCHAR(5)
AS
BEGIN
INSERT INTO "Časovi vožnje"("id_instruktora", "id_prolaznika", "broj_casa", "datum", "vrijeme")
VALUES (@id_instruktora, @id_prolaznika, @broj_casa, @datum, @vrijeme)
end//
DELIMITER ;

-- Dumping structure for table autoskolaipi.Instruktori
CREATE TABLE IF NOT EXISTS "Instruktori" (
	"id_instruktora" INT NOT NULL,
	"ime" VARCHAR(15) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"prezime" VARCHAR(15) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"plata" INT NULL DEFAULT NULL,
	PRIMARY KEY ("id_instruktora")
);

-- Data exporting was unselected.

-- Dumping structure for table autoskolaipi.Ispiti vožnje
CREATE TABLE IF NOT EXISTS "Ispiti vožnje" (
	"id_ispita" INT NOT NULL,
	"datum" VARCHAR(10) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"vrijeme" VARCHAR(5) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	PRIMARY KEY ("id_ispita")
);

-- Data exporting was unselected.

-- Dumping structure for procedure autoskolaipi.ispit_voznje
DELIMITER //
CREATE PROCEDURE ispit_voznje
@id_ispita int, @datum VARCHAR(10), @vrijeme VARCHAR(5)
AS
BEGIN
INSERT INTO "Ispiti vožnje"(id_ispita, datum, vrijeme)
VALUES (@id_ispita, @datum, @vrijeme)
end//
DELIMITER ;

-- Dumping structure for table autoskolaipi.Predavanja
CREATE TABLE IF NOT EXISTS "Predavanja" (
	"id_predavanja" INT NOT NULL,
	"id_instruktora" INT NULL DEFAULT NULL,
	"datum" VARCHAR(10) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"vrijeme" VARCHAR(5) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	FOREIGN KEY INDEX "FK__Predavanj__id_in__3F466844" ("id_instruktora"),
	PRIMARY KEY ("id_predavanja"),
	CONSTRAINT "FK__Predavanj__id_in__3F466844" FOREIGN KEY ("id_instruktora") REFERENCES "Instruktori" ("id_instruktora") ON UPDATE NO_ACTION ON DELETE NO_ACTION
);

-- Data exporting was unselected.

-- Dumping structure for procedure autoskolaipi.predavanje
DELIMITER //
CREATE PROCEDURE predavanje
@id_predavanja INT, @id_instruktora INT, @datum VARCHAR(10), @vrijeme VARCHAR(5)
AS 
BEGIN
INSERT INTO Predavanja("id_predavanja", "id_instruktora", "datum", "vrijeme")
VALUES (@id_predavanja, @id_instruktora, @datum, @vrijeme)
end
	//
DELIMITER ;

-- Dumping structure for table autoskolaipi.Prolaznici
CREATE TABLE IF NOT EXISTS "Prolaznici" (
	"id_prolaznika" INT NOT NULL,
	"ime" VARCHAR(15) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"prezime" VARCHAR(15) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	PRIMARY KEY ("id_prolaznika")
);

-- Data exporting was unselected.

-- Dumping structure for table autoskolaipi.Prolaznici teorije
CREATE TABLE IF NOT EXISTS "Prolaznici teorije" (
	"id_ispita" INT NOT NULL,
	"id_prolaznika" INT NOT NULL,
	"polozeno" VARCHAR(2) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	FOREIGN KEY INDEX "FK__Prolaznic__id_is__693CA210" ("id_ispita"),
	FOREIGN KEY INDEX "FK__Prolaznic__id_pr__6A30C649" ("id_prolaznika"),
	PRIMARY KEY ("id_ispita", "id_prolaznika"),
	CONSTRAINT "FK__Prolaznic__id_pr__6A30C649" FOREIGN KEY ("id_prolaznika") REFERENCES "Prolaznici" ("id_prolaznika") ON UPDATE NO_ACTION ON DELETE NO_ACTION,
	CONSTRAINT "FK__Prolaznic__id_is__693CA210" FOREIGN KEY ("id_ispita") REFERENCES "Teoretski ispiti" ("id_ispita") ON UPDATE NO_ACTION ON DELETE NO_ACTION
);

-- Data exporting was unselected.

-- Dumping structure for table autoskolaipi.Prolaznici vožnje
CREATE TABLE IF NOT EXISTS "Prolaznici vožnje" (
	"id_ispita" INT NOT NULL,
	"id_prolaznika" INT NOT NULL,
	"polozeno" VARCHAR(2) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	FOREIGN KEY INDEX "FK__Prolaznic__id_is__6EF57B66" ("id_ispita"),
	FOREIGN KEY INDEX "FK__Prolaznic__id_pr__6FE99F9F" ("id_prolaznika"),
	PRIMARY KEY ("id_ispita", "id_prolaznika"),
	CONSTRAINT "FK__Prolaznic__id_pr__6FE99F9F" FOREIGN KEY ("id_prolaznika") REFERENCES "Prolaznici" ("id_prolaznika") ON UPDATE NO_ACTION ON DELETE NO_ACTION,
	CONSTRAINT "FK__Prolaznic__id_is__6EF57B66" FOREIGN KEY ("id_ispita") REFERENCES "Ispiti vožnje" ("id_ispita") ON UPDATE NO_ACTION ON DELETE NO_ACTION
);

-- Data exporting was unselected.

-- Dumping structure for procedure autoskolaipi.prolaznik_teorije
DELIMITER //
CREATE PROCEDURE prolaznik_teorije
@id_ispita INT, @id_prolaznika INT, @polozeno VARCHAR(2)
AS
BEGIN
INSERT INTO "Prolaznici teorije"(id_ispita, id_prolaznika, polozeno)
VALUES (@id_ispita, @id_prolaznika, @polozeno)
end//
DELIMITER ;

-- Dumping structure for procedure autoskolaipi.prolaznik_voznje
DELIMITER //
CREATE PROCEDURE prolaznik_voznje
@id_ispita INT, @id_prolaznika INT, @polozeno VARCHAR(2)
AS
BEGIN
INSERT INTO "Prolaznici vožnje"(id_ispita, id_prolaznika, polozeno)
VALUES (@id_ispita, @id_prolaznika, @polozeno)
end
//
DELIMITER ;

-- Dumping structure for table autoskolaipi.Teoretski ispiti
CREATE TABLE IF NOT EXISTS "Teoretski ispiti" (
	"id_ispita" INT NOT NULL,
	"datum" VARCHAR(10) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"vrijeme" VARCHAR(5) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	PRIMARY KEY ("id_ispita")
);

-- Data exporting was unselected.

-- Dumping structure for procedure autoskolaipi.teoretski_ispit
DELIMITER //
CREATE PROCEDURE teoretski_ispit
@id_ispita INT, @datum VARCHAR(10), @vrijeme VARCHAR(5)
AS
BEGIN
INSERT INTO "Teoretski ispiti"(id_ispita, datum, vrijeme)
VALUES (@id_ispita, @datum, @vrijeme)
end//
DELIMITER ;

-- Dumping structure for table autoskolaipi.Uplate
CREATE TABLE IF NOT EXISTS "Uplate" (
	"id_uplate" INT NOT NULL,
	"id_prolaznika" INT NULL DEFAULT NULL,
	"kolicina_uplate" FLOAT(53) NULL DEFAULT NULL,
	"datum" VARCHAR(10) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	FOREIGN KEY INDEX "FK__Uplate__id_prola__60A75C0F" ("id_prolaznika"),
	PRIMARY KEY ("id_uplate"),
	CONSTRAINT "FK__Uplate__id_prola__60A75C0F" FOREIGN KEY ("id_prolaznika") REFERENCES "Prolaznici" ("id_prolaznika") ON UPDATE NO_ACTION ON DELETE NO_ACTION
);

-- Data exporting was unselected.

-- Dumping structure for table autoskolaipi.Učesnici predavanja
CREATE TABLE IF NOT EXISTS "Učesnici predavanja" 
);

-- Data exporting was unselected.

-- Dumping structure for table autoskolaipi.Vozila
CREATE TABLE IF NOT EXISTS "Vozila" (
	"registracija" VARCHAR(10) NOT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"tip_vozila" VARCHAR(20) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	"boja" VARCHAR(15) NULL DEFAULT NULL COLLATE 'SQL_Latin1_General_CP1_CI_AS',
	PRIMARY KEY ("registracija")
);

-- Data exporting was unselected.

-- Dumping structure for table autoskolaipi.Časovi vožnje
CREATE TABLE IF NOT EXISTS "Časovi vožnje" 
);

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
