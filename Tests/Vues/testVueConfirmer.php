<?php

require_once 'Vue/Vue.php';
$commentaire = [
        'id' => '999',
        'article_id' => '111',
        'date' => '2017-12-31',
        'auteur' => 'auteur Test',
        'prive' => '1',
        'titre' => 'titre Test',
        'texte' => 'texte Test',
    ];
$vue = new Vue('Confirmer');
$vue->generer(['commentaire' => $commentaire]);

