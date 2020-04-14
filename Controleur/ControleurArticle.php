<?php

require_once 'Modele/Article.php';
require_once 'Modele/Commentaire.php';
require_once 'Vue/Vue.php';

class ControleurArticle {

    private $article;
    private $commentaire;

    public function __construct() {
        $this->article = new Article();
        $this->commentaire = new Commentaire();
    }

// Affiche la liste de tous les articles du blog
    public function articles() {
        $articles = $this->article->getArticles();
        $vue = new Vue("Articles");
        $vue->generer(['articles' => $articles]);
    }

// Affiche les détails sur un article
    public function article($idArticle, $erreur) {
        $article = $this->article->getArticle($idArticle);
        $commentaires = $this->commentaire->getCommentaires($idArticle);
        $vue = new Vue("Article");
        $vue->generer(['article' => $article, 'commentaires' => $commentaires, 'erreur' => $erreur]);
    }

    public function nouvelArticle() {
        $vue = new Vue("Ajouter");
        $vue->generer();
    }

// Enregistre le nouvel article et retourne à la liste des articles
    public function ajouter($article) {
        $this->article->setArticle($article);
        $this->articles();
    }
    
// Modifier un article existant    
    public function modifierArticle($id) {
        $article = $this->article->getArticle($id);
        $vue = new Vue("ModifierArticle");
        $vue->generer(['article' => $article]);
    }
    
// Enregistre l'article modifié et retourne à la liste des articles
    public function miseAJourArticle($article) {
        $this->article->updateArticle($article);
        $this->articles();
    }
}
