CREATE TABLE   IF NOT EXISTS  `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `writer` varchar(255) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `modified_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `articles` set writer='admin001', create_time='0';
