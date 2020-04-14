<?php

require_once 'Modele/Type.php';

class ControleurType {

    private $type;

    public function __construct() {
        $this->type = new Type();
    }

// recherche et retourne les types pour l'autocomplete
    public function quelsTypes($term) {
        echo $this->type->searchType($term);
    }

}
