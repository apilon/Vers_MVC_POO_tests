<?php

require_once 'Modele/Modele.php';

/**
 * Fournit les services d'accès aux articles 
 * 
 * @author André Pilon
 */
class Article extends Modele {

// Renvoie la liste de tous les articles, triés par identifiant décroissant
    public function getArticles() {
        $sql = 'select * from Articles'
                . ' order by ID desc';
        $articles = $this->executerRequete($sql);
        return $articles;
    }

// Renvoie la liste de tous les articles, triés par identifiant décroissant
    public function setArticle($article) {
        $sql = 'INSERT INTO articles (titre, sous_titre, utilisateur_id, date, texte, type) VALUES(?, ?, ?, NOW(), ?, ?)';
        $result = $this->executerRequete($sql, [$article[titre], $article[sous_titre], $article[utilisateur_id], $article[texte], $article[type]]);
        return $result;
    }

// Renvoie les informations sur un article
    function getArticle($idArticle) {
        $sql = 'select * from Articles'
                . ' where ID=?';
        $article = $this->executerRequete($sql, [$idArticle]);
        if ($article->rowCount() == 1) {
            return $article->fetch();  // Accès à la première ligne de résultat
        } else {
            throw new Exception("Aucun article ne correspond à l'identifiant '$idArticle'");
        }
    }
// Met à jour un article
    public function updateArticle($article) {
        $sql = 'UPDATE Articles'
                . ' SET titre = ?, sous_titre = ?, utilisateur_id = ?, date = NOW(), texte = ?, type = ?'
                . ' WHERE id = ?';
        $result = $this->executerRequete($sql, [$article['titre'], $article['sous_titre'], $article['utilisateur_id'], $article['texte'], $article['type'], $article['id']]);
        return $result;
    }
    
}
