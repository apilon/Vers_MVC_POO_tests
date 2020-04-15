<?php

require_once 'Modele/Commentaire.php';
require_once 'Vue/Vue.php';

class ControleurCommentaire {

    private $commentaire;

    public function __construct() {
        $this->commentaire = new Commentaire();
    }

// Ajoute un commentaire à un article
    public function commentaire($commentaire) {
        $validation_courriel = filter_var($commentaire['auteur'], FILTER_VALIDATE_EMAIL);
        if ($validation_courriel) {
            if (H204A4_PUBLIC) {
                $_SESSION['h204a4message'] = "Ajouter un commentaire n'est pas permis en démonstration";
            } else {
                // Ajouter le commentaire à l'aide du modèle
                $this->commentaire->setCommentaire($commentaire);
            }
            //Recharger la page pour mettre à jour la liste des commentaires associés
            header('Location: index.php?action=article&id=' . $commentaire['article_id']);
        } else {
            //Recharger la page avec une erreur près du courriel
            header('Location: index.php?action=article&id=' . $commentaire['article_id'] . '&erreur=courriel');
        }
    }

// Confirmer la suppression d'un commentaire
    public function confirmer($id) {
        // Lire le commentaire à l'aide du modèle
        $commentaire = $this->commentaire->getCommentaire($id);
        $vue = new Vue("Confirmer");
        $vue->generer(array('commentaire' => $commentaire));
    }

// Supprimer un commentaire
    public function supprimer($id) {
        // Lire le commentaire afin d'obtenir le id de l'article associé
        $commentaire = $this->commentaire->getCommentaire($id);
        if (H204A4_PUBLIC) {
            $_SESSION['h204a4message'] = "Supprimer un commentaire n'est pas permis en démonstration";
        } else {
            // Supprimer le commentaire à l'aide du modèle
            $this->commentaire->deleteCommentaire($id);
        }
        //Recharger la page pour mettre à jour la liste des commentaires associés
        header('Location: index.php?action=article&id=' . $commentaire['article_id']);
    }

}
