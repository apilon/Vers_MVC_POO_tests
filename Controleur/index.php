<?php

require 'Controleur/Controleur.php';

try {
    if (isset($_GET['action'])) {

        // Afficher un article
        if ($_GET['action'] == 'article') {
            if (isset($_GET['id'])) {
                // intval renvoie la valeur numérique du paramètre ou 0 en cas d'échec
                $id = intval($_GET['id']);
                if ($id != 0) {
                    $erreur = isset($_GET['erreur']) ? $_GET['erreur'] : '';
                    article($id, $erreur);
                } else
                    throw new Exception("Identifiant d'article incorrect");
            } else
                throw new Exception("Aucun identifiant d'article");

        // Ajouter un commentaire
        } else if ($_GET['action'] == 'commentaire') {
            if (isset($_POST['article_id'])) {
                // intval renvoie la valeur numérique du paramètre ou 0 en cas d'échec
                $id = intval($_POST['article_id']);
                if ($id != 0) {
                    // vérifier si l'article existe;
                    $article = getArticle($id);
                    // Récupérer les données du formulaire
                    $commentaire = $_POST;
                    // Ajuster la valeur de la case à cocher
                    $commentaire['prive'] = (isset($_POST['prive'])) ? 1 : 0;
                    //Réaliser l'action commentaire du contrôleur
                    commentaire($commentaire);
                } else
                    throw new Exception("Identifiant d'article incorrect");
            } else
                throw new Exception("Aucun identifiant d'article");

        // Confirmer la suppression
        } else if ($_GET['action'] == 'confirmer') {
            if (isset($_GET['id'])) {
                // intval renvoie la valeur numérique du paramètre ou 0 en cas d'échec
                $id = intval($_GET['id']);
                if ($id != 0) {
                    confirmer($id);
                } else
                    throw new Exception("Identifiant de commentaire incorrect");
            } else
                throw new Exception("Aucun identifiant de commentaire");

        // Supprimer un commentaire
        } else if ($_GET['action'] == 'supprimer') {
            if (isset($_POST['id'])) {
                // intval renvoie la valeur numérique du paramètre ou 0 en cas d'échec
                $id = intval($_POST['id']);
                if ($id != 0) {
                    supprimer($id);
                } else
                    throw new Exception("Identifiant de commentaire incorrect");
            } else
                throw new Exception("Aucun identifiant de commentaire");

        // Ajouter un article
        } else if ($_GET['action'] == 'nouvelArticle') {
            nouvelArticle();

        // Enregistrer l'article
        } else if ($_GET['action'] == 'ajouter') {
            $article = $_POST;
            ajouter($article);

        // Cherche les types pour l'autocomplete
        } else if ($_GET['action'] == 'quelsTypes') {
            quelsTypes($_GET['term']);
            
        } else {
            // Fin des actions
            throw new Exception("Action non valide");
        }
    } else {
        accueil();  // action par défaut
    }
} catch (Exception $e) {
    erreur($e->getMessage());
}
