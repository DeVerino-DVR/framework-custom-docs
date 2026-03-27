-- LcCore Database Schema

CREATE TABLE IF NOT EXISTS `lc_characters` (
    `id`        INT AUTO_INCREMENT PRIMARY KEY,
    `discord`   VARCHAR(50) NOT NULL,
    `group`     VARCHAR(50) DEFAULT 'user',
    `firstname` VARCHAR(50) DEFAULT '',
    `lastname`  VARCHAR(50) DEFAULT '',
    `job`       JSON DEFAULT ('{"name":"unemployed","grade":0,"label":"Sans emploi"}'),
    `gang`      VARCHAR(50) DEFAULT 'none',
    `money`     DOUBLE DEFAULT 50.0,
    `gold`      DOUBLE DEFAULT 0.0,
    `inventory` JSON DEFAULT ('[]'),
    `skin`      JSON DEFAULT ('{}'),
    `coords`    JSON DEFAULT ('{"x":-279.22,"y":805.39,"z":119.37}'),
    `slots`     INT DEFAULT 50,
    `isdead`    TINYINT(1) DEFAULT 0,
    `xp`        INT DEFAULT 0,
    INDEX `idx_discord` (`discord`)
);

CREATE TABLE IF NOT EXISTS `lc_bans` (
    `id`         INT AUTO_INCREMENT PRIMARY KEY,
    `discord`    VARCHAR(50) NOT NULL,
    `reason`     VARCHAR(255) DEFAULT NULL,
    `expire`     DATETIME DEFAULT NULL,
    `banned_by`  VARCHAR(50) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `lc_counties` (
    `id`    VARCHAR(50) PRIMARY KEY,          -- ex: 'new_hanover', 'lemoyne', 'new_austin'
    `name`  VARCHAR(100) NOT NULL,
    `label` VARCHAR(100) NOT NULL,
    `tax`   DOUBLE DEFAULT 0.0,              -- pourcentage de taxe (ex: 15.0 = 15%)
    `mayor` INT DEFAULT NULL,                -- charId du maire
    FOREIGN KEY (`mayor`) REFERENCES `lc_characters`(`id`) ON DELETE SET NULL
);

-- Comtes par defaut
INSERT IGNORE INTO `lc_counties` (`id`, `name`, `label`, `tax`) VALUES
    ('new_hanover',  'New Hanover',  'Comte de New Hanover',  0.0),
    ('lemoyne',      'Lemoyne',      'Comte de Lemoyne',      0.0),
    ('new_austin',   'New Austin',   'Comte de New Austin',   0.0),
    ('west_elizabeth','West Elizabeth','Comte de West Elizabeth',0.0),
    ('ambarino',     'Ambarino',     'Comte d Ambarino',      0.0);
