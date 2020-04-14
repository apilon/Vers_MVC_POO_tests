<?php

//Attention il s'agit d'identificateurs à portée globale alors les nom doivent être exclusifs
//Une constante nommée simplement "public" ne serait pas une bonne idée
define ("H204A4_PUBLIC", true); //si public alors aucune modification permise à la BD
session_start(); // Le message à afficher dans le gabarit lorsque ce n'est pas permis sera dans $_SESSION['h204a4message']

require 'Modele/Modele.php';

// Affiche la liste de tous les articles du blog
function accueil() {
    $articles = getArticles();
    require 'Vue/vueAccueil.php';
}

// Affiche la liste de tous les articles du blog
function apropos() {
    require 'Vue/vueApropos.php';
}

// Affiche les détails sur un article
function article($idArticle, $erreur) {
    $article = getArticle($idArticle);
    $commentaires = getCommentaires($idArticle);
    require 'Vue/vueArticle.php';
}

// Ajoute un commentaire à un article
function commentaire($commentaire) {
    $validation_courriel = filter_var($commentaire['auteur'], FILTER_VALIDATE_EMAIL);
    if ($validation_courriel) {
        if (H204A4_PUBLIC) {
            $_SESSION['h204a4message'] = "Ajouter un commentaire n'est pas permis en démonstration";
        } else {
            // Ajouter le commentaire à l'aide du modèle
            setCommentaire($commentaire);
        }
        //Recharger la page pour mettre à jour la liste des commentaires associés
        header('Location: index.php?action=article&id=' . $commentaire['article_id']);
    } else {
        //Recharger la page avec une erreur près du courriel
        header('Location: index.php?action=article&id=' . $commentaire['article_id'] . '&erreur=courriel');
    }
}

// Confirmer la suppression d'un commentaire
function confirmer($id) {
    // Lire le commentaire à l'aide du modèle
    $commentaire = getCommentaire($id);
    require 'Vue/vueConfirmer.php';
}

// Supprimer un commentaire
function supprimer($id) {
    // Lire le commentaire afin d'obtenir le id de l'article associé
    $commentaire = getCommentaire($id);
    if (H204A4_PUBLIC) {
        $_SESSION['h204a4message'] = "Supprimer un commentaire n'est pas permis en démonstration";
    } else {
        // Supprimer le commentaire à l'aide du modèle
        deleteCommentaire($id);
    }
    //Recharger la page pour mettre à jour la liste des commentaires associés
    header('Location: index.php?action=article&id=' . $commentaire['article_id']);
}

function nouvelArticle() {
    require 'Vue/vueAjouter.php';
}

// Enregistre le nouvel article et retourne à l'accueil
function ajouter($article) {
    if (H204A4_PUBLIC) {
        $_SESSION['h204a4message'] = "Ajouter un article n'est pas permis en démonstration";
    } else {
        setArticle($article);
    }
    header('Location: index.php');
}

// recherche et retourne les types pour l'autocomplete
function quelsTypes($term) {
    echo searchType($term);
}

// Affiche une erreur
function erreur($msgErreur) {
    require 'Vue/vueErreur.php';
}
