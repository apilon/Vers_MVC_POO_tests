-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 26 Mars 2018 à 19:50
-- Version du serveur :  5.6.37
-- Version de PHP :  5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `blog_triggers`
--

-- --------------------------------------------------------

--
-- Structure de la table `audit`
--

CREATE TABLE IF NOT EXISTS `audit` (
  `id` mediumint(8) unsigned NOT NULL,
  `blog_id` mediumint(8) unsigned NOT NULL,
  `changetype` enum('NEW','EDIT','DELETE') NOT NULL,
  `changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `audit`
--

INSERT INTO `audit` (`id`, `blog_id`, `changetype`, `changetime`) VALUES
(4, 2, 'NEW', '2018-03-26 19:18:18');

-- --------------------------------------------------------

--
-- Structure de la table `audit_archive`
--

CREATE TABLE IF NOT EXISTS `audit_archive` (
  `id` mediumint(8) unsigned NOT NULL,
  `blog_id` mediumint(8) unsigned NOT NULL,
  `changetype` enum('NEW','EDIT','DELETE') NOT NULL,
  `changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `audit_archive`
--

INSERT INTO `audit_archive` (`id`, `blog_id`, `changetype`, `changetime`) VALUES
(1, 1, 'NEW', '2018-03-26 19:11:48'),
(2, 1, 'EDIT', '2018-03-26 19:12:38'),
(3, 1, 'DELETE', '2018-03-26 19:13:31'),
(5, 3, 'NEW', '2018-03-26 19:18:37'),
(6, 3, 'DELETE', '2018-03-26 19:44:51');

-- --------------------------------------------------------

--
-- Structure de la table `blog`
--

CREATE TABLE IF NOT EXISTS `blog` (
  `id` mediumint(8) unsigned NOT NULL,
  `title` text,
  `content` text,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Blog posts';

--
-- Contenu de la table `blog`
--

INSERT INTO `blog` (`id`, `title`, `content`, `deleted`) VALUES
(2, 'Article two', 'Initial text 2.', 0);

--
-- Déclencheurs `blog`
--
DELIMITER $$
CREATE TRIGGER `blog_after_insert` AFTER INSERT ON `blog`
 FOR EACH ROW BEGIN
	
		IF NEW.deleted THEN
			SET @changetype = 'DELETE';
		ELSE
			SET @changetype = 'NEW';
		END IF;
    
		INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, @changetype);
		
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `blog_after_update` AFTER UPDATE ON `blog`
 FOR EACH ROW BEGIN
	
		IF NEW.deleted THEN
			SET @changetype = 'DELETE';
		ELSE
			SET @changetype = 'EDIT';
		END IF;
    
		INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, @changetype);
		
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `blog_archive`
--

CREATE TABLE IF NOT EXISTS `blog_archive` (
  `id` mediumint(8) unsigned NOT NULL,
  `title` text,
  `content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Blog posts archive';

--
-- Contenu de la table `blog_archive`
--

INSERT INTO `blog_archive` (`id`, `title`, `content`) VALUES
(1, 'Article One', 'Edited text'),
(3, 'Article three', 'Initial text 3.');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `audit`
--
ALTER TABLE `audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_blog_id` (`blog_id`),
  ADD KEY `ix_changetype` (`changetype`),
  ADD KEY `ix_changetime` (`changetime`);

--
-- Index pour la table `audit_archive`
--
ALTER TABLE `audit_archive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_blog_id` (`blog_id`),
  ADD KEY `ix_changetype` (`changetype`),
  ADD KEY `ix_changetime` (`changetime`);

--
-- Index pour la table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_deleted` (`deleted`);

--
-- Index pour la table `blog_archive`
--
ALTER TABLE `blog_archive`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `audit`
--
ALTER TABLE `audit`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `blog`
--
ALTER TABLE `blog`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `FK_audit_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `audit_archive`
--
ALTER TABLE `audit_archive`
  ADD CONSTRAINT `FK_audit_blog_archive_id` FOREIGN KEY (`blog_id`) REFERENCES `blog_archive` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Événements
--
CREATE DEFINER=`root`@`localhost` EVENT `archive_blogs` ON SCHEDULE EVERY 1 MINUTE STARTS '2018-03-26 15:30:15' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	
		-- copy deleted posts
		INSERT INTO blog_archive (id, title, content) 
		SELECT id, title, content
		FROM blog WHERE deleted = 1;

		-- copy associated audit records
		INSERT INTO audit_archive (id, blog_id, changetype, changetime) 
		SELECT audit.id, audit.blog_id, audit.changetype, audit.changetime 
		FROM audit
		JOIN blog ON audit.blog_id = blog.id WHERE blog.deleted = 1;
		
		-- remove deleted blogs and audit entries
		DELETE FROM blog WHERE deleted = 1;
	    
	END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
