CREATE TABLE IF NOT EXISTS `user_xp` (
  `identifier` varchar(80) NOT NULL,
  `xp` int(11) NOT NULL DEFAULT 0,
  `rank` int(11) DEFAULT 1,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;