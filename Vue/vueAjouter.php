<?php $this->titre = "Le Blogue du prof - " . $article['titre']; ?>

<header>
    <h1 id="titreReponses">Ajouter un article de l'utilisateur 1 :</h1>
</header>
<form action="index.php?action=ajouter" method="post">
    <h2>Ajouter un article</h2>
    <p>
        <label for="auteur">Titre</label> : <input type="text" name="titre" id="titre" /> <br />
        <label for="sous_titre">Sous-titre</label> :  <input type="text" name="sous_titre" id="sous_titre" /><br />
        <label for="texte">Texte de l'article</label> :  <textarea type="text" name="texte" id="texte" >Écrivez votre article ici</textarea><br />
        <label for="type">Sujet</label> : <input type="text" name="type" id="auto" /> <br />
        <input type="hidden" name="utilisateur_id" value="1" /><br />
        <input type="submit" value="Envoyer" />
    </p>
</form>


