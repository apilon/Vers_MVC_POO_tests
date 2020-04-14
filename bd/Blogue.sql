-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 26 Mars 2018 à 23:57
-- Version du serveur :  5.6.37
-- Version de PHP :  5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `Blogue`
--

-- --------------------------------------------------------

--
-- Structure de la table `Articles`
--

CREATE TABLE IF NOT EXISTS `Articles` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sous_titre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `utilisateur_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `texte` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `Articles`
--

INSERT INTO `Articles` (`id`, `titre`, `sous_titre`, `utilisateur_id`, `date`, `texte`, `type`) VALUES
(1, 'Premier article', 'Premier sous-titre', 1, '2018-01-24', 'Texte du premier article', 'un type'),
(2, 'Deuxième article', 'Deuxième sous-titre', 1, '2018-02-26', 'Texte du deuxième article', 'un type'),
(3, 'Test d''ajout', 'S-T ajouté', 1, '2018-03-12', 'article ajouté', 'PHP'),
(4, 'Test d''autocomplete', 'S-T autocomplete', 1, '2018-03-12', 'Article sur l''autocomplete en MVC', 'Java');

-- --------------------------------------------------------

--
-- Structure de la table `Commentaires`
--

CREATE TABLE IF NOT EXISTS `Commentaires` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `auteur` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `titre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `texte` text COLLATE utf8_unicode_ci NOT NULL,
  `prive` tinyint(1) NOT NULL,
  `efface` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `Commentaires`
--

INSERT INTO `Commentaires` (`id`, `article_id`, `date`, `auteur`, `titre`, `texte`, `prive`, `efface`) VALUES
(5, 1, '2018-01-24', 'Moi mod.', 'Mon commentaire mod.', 'Voici mon commentaire modifié', 1, 0),
(7, 1, '2018-01-29', 'Lui mod.', 'Son commentaire mod.', 'Voici son commentaire modifié', 1, 0),
(9, 2, '2018-01-30', 'Nous', 'notre commentaire', 'Le texte de notre commentaire', 1, 0),
(10, 2, '2018-02-01', 'Vous', 'Votre commentaire', 'Le texte de votre commentaire', 0, 0),
(23, 1, '2018-03-12', 'Toi', 'Ton commentaire', 'Le texte de ton commentaire', 1, 0),
(29, 2, '2018-03-12', 'a@b.c', 'Test de courriel', 'Commentaire d''un auteur avec courriel', 1, 0);

--
-- Déclencheurs `Commentaires`
--
DELIMITER $$
CREATE TRIGGER `commentaires_after_insert` AFTER INSERT ON `commentaires`
 FOR EACH ROW BEGIN
	
		IF NEW.efface THEN
			SET @changetype = 'Effacé';
		ELSE
			SET @changetype = 'Nouveau';
		END IF;
    
		INSERT INTO commentaires_audit (commentaire_id, changetype) VALUES (NEW.id, @changetype);
		
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `commentaires_after_update` AFTER UPDATE ON `commentaires`
 FOR EACH ROW BEGIN
	
		IF NEW.efface THEN
			SET @changetype = 'Effacé';
		ELSE
			SET @changetype = 'Modifié';
		END IF;
    
		INSERT INTO commentaires_audit (commentaire_id, changetype) VALUES (NEW.id, @changetype);
		
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `commentaires_audit`
--

CREATE TABLE IF NOT EXISTS `commentaires_audit` (
  `id` int(11) NOT NULL,
  `commentaire_id` int(11) NOT NULL,
  `changetype` enum('Nouveau','Modifié','effacé') NOT NULL,
  `changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `commentaires_audit`
--

INSERT INTO `commentaires_audit` (`id`, `commentaire_id`, `changetype`, `changetime`) VALUES
(1, 9, 'effacé', '2018-03-26 23:53:33'),
(2, 10, 'effacé', '2018-03-26 23:55:29'),
(3, 9, 'Modifié', '2018-03-26 23:55:58'),
(4, 10, 'Modifié', '2018-03-26 23:56:09');

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `types`
--

INSERT INTO `types` (`id`, `type`) VALUES
(1, 'ActionScript'),
(2, 'AppleScript'),
(3, 'Asp'),
(4, 'BASIC'),
(5, 'C'),
(6, 'C++'),
(7, 'Clojure'),
(8, 'COBOL'),
(9, 'ColdFusion'),
(10, 'Erlang'),
(11, 'Fortran'),
(12, 'Groovy'),
(13, 'Haskell'),
(14, 'Java'),
(15, 'JavaScript'),
(16, 'Lisp'),
(17, 'Perl'),
(18, 'PHP'),
(19, 'Python'),
(20, 'Ruby'),
(21, 'Scala'),
(22, 'Scheme');

-- --------------------------------------------------------

--
-- Structure de la table `Utilisateurs`
--

CREATE TABLE IF NOT EXISTS `Utilisateurs` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `identifiant` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `Utilisateurs`
--

INSERT INTO `Utilisateurs` (`id`, `nom`, `identifiant`, `mot_de_passe`) VALUES
(1, 'André Pilon', 'apilon', 'prof');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Articles`
--
ALTER TABLE `Articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utilisateur_id` (`utilisateur_id`);

--
-- Index pour la table `Commentaires`
--
ALTER TABLE `Commentaires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`article_id`);

--
-- Index pour la table `commentaires_audit`
--
ALTER TABLE `commentaires_audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_commentaire_id` (`commentaire_id`),
  ADD KEY `ix_changetype` (`changetype`),
  ADD KEY `ix_changetime` (`changetime`);

--
-- Index pour la table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Utilisateurs`
--
ALTER TABLE `Utilisateurs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Articles`
--
ALTER TABLE `Articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `Commentaires`
--
ALTER TABLE `Commentaires`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT pour la table `commentaires_audit`
--
ALTER TABLE `commentaires_audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `types`
--
ALTER TABLE `types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT pour la table `Utilisateurs`
--
ALTER TABLE `Utilisateurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Articles`
--
ALTER TABLE `Articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `Utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Commentaires`
--
ALTER TABLE `Commentaires`
  ADD CONSTRAINT `commentaires_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `Articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commentaires_audit`
--
ALTER TABLE `commentaires_audit`
  ADD CONSTRAINT `FK_audit_commentaire_id` FOREIGN KEY (`commentaire_id`) REFERENCES `commentaires` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
