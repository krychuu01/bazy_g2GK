CREATE TABLE `pracownicy` (
  `id_pracownika` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `rola` ENUM('obsluga', 'sprzataczka', 'trener', 'menadzer', 'zarzad', 'ksiegowa', 'dietetyk') NULL,
  `pensja` INT NOT NULL,
  `data_ur` DATE NOT NULL,
  `pesel` VARCHAR(12) NOT NULL,
  `nr_tel` VARCHAR(9) NOT NULL,
  `adres` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_pracownika`))

CREATE TABLE `sklep` (
  `id_produktu` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `ilosc_sztuk` INT NOT NULL,
  `cena` FLOAT NOT NULL,
  `id_pracownika` INT NULL,
  PRIMARY KEY (`id_produktu`),
  INDEX `fk_sklep_pracownicy_idx` (`id_pracownika` ASC) VISIBLE,
  CONSTRAINT `fk_sklep_pracownicy`
    FOREIGN KEY (`id_pracownika`)
    REFERENCES `krychg`.`pracownicy` (`id_pracownika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE TABLE `klienci` (
  `id_klienta` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `naziwsko` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `nr_tel` VARCHAR(9) NOT NULL,
  `adres_zamieszkania` VARCHAR(255) NOT NULL,
  `pesel` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_klienta`))

CREATE TABLE `karnety` (
  `id_produktu` INT NOT NULL,
  `id_klienta` INT NOT NULL,
  `data_wykupienia_karnetu` DATE NOT NULL,
  `data_wygasniecia_karnetu` DATE NOT NULL,
  PRIMARY KEY (`id_produktu`, `id_klienta`),
  INDEX `fk_sklep_has_klienci_klienci1_idx` (`id_klienta` ASC) VISIBLE,
  INDEX `fk_sklep_has_klienci_sklep1_idx` (`id_produktu` ASC) VISIBLE,
  CONSTRAINT `fk_sklep_has_klienci_sklep1`
    FOREIGN KEY (`id_produktu`)
    REFERENCES `krychg`.`sklep` (`id_produktu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sklep_has_klienci_klienci1`
    FOREIGN KEY (`id_klienta`)
    REFERENCES `krychg`.`klienci` (`id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE TABLE `treningi` (
  `id_treningu` INT NOT NULL,
  `id_pracownika` INT NOT NULL,
  `id_klienta` INT NOT NULL,
  `id_produktu` INT NOT NULL,
  `data_treningu` DATE NOT NULL,
  INDEX `fk_treningi_pracownicy1_idx` (`id_pracownika` ASC) VISIBLE,
  INDEX `fk_treningi_klienci1_idx` (`id_klienta` ASC) VISIBLE,
  INDEX `fk_treningi_sklep1_idx` (`id_produktu` ASC) VISIBLE,
  CONSTRAINT `fk_treningi_pracownicy1`
    FOREIGN KEY (`id_pracownika`)
    REFERENCES `krychg`.`pracownicy` (`id_pracownika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_treningi_klienci1`
    FOREIGN KEY (`id_klienta`)
    REFERENCES `krychg`.`klienci` (`id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_treningi_sklep1`
    FOREIGN KEY (`id_produktu`)
    REFERENCES `krychg`.`sklep` (`id_produktu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE TABLE `wydatki` (
  `id_wydatki` INT NOT NULL AUTO_INCREMENT,
  `id_pracownika` INT NOT NULL,
  `data_wydatkow` DATE NOT NULL,
  `nazwa` VARCHAR(255) NOT NULL,
  `kwota` FLOAT NOT NULL,
  PRIMARY KEY (`id_wydatki`),
  INDEX `fk_wydatki_pracownicy1_idx` (`id_pracownika` ASC) VISIBLE,
  CONSTRAINT `fk_wydatki_pracownicy1`
    FOREIGN KEY (`id_pracownika`)
    REFERENCES `krychg`.`pracownicy` (`id_pracownika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE TABLE `ilosc_wejsc` (
  `id_produktu` INT NOT NULL,
  `id_klienta` INT NOT NULL,
  `ilosc_wejsc` INT UNSIGNED NULL,
  `czy_open` TINYINT(1) NULL,
  CONSTRAINT `fk_ilosc_wejsc_karnety1`
    FOREIGN KEY (`id_produktu` , `id_klienta`)
    REFERENCES `krychg`.`karnety` (`id_produktu` , `id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

