CREATE TABLE `commentaires_audit` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`commentaire_id` int(11) NOT NULL,
	`changetype` enum('Nouveau','Modifié','effacé') NOT NULL,
	`changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `ix_commentaire_id` (`commentaire_id`),
	KEY `ix_changetype` (`changetype`),
	KEY `ix_changetime` (`changetime`),
	CONSTRAINT `FK_audit_commentaire_id` FOREIGN KEY (`commentaire_id`) REFERENCES `commentaires` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
