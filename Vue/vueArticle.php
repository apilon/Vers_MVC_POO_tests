<?php $this->titre = "Le Blogue du prof - " . $article['titre']; ?>

<article>
    <header>
        <h1 class="titreArticle"><?= $article['titre'] ?></h1>
        <time><?= $article['date'] ?></time>, par utilisateur #<?= $article['utilisateur_id'] ?>
        <h3 class=""><?= $article['sous_titre'] ?></h3>
    </header>
    <p><?= $article['texte'] ?></p>
    <p><?= $article['type'] ?></p>
</article>
<hr />
<header>
    <h1 id="titreReponses">Réponses à <?= $article['titre'] ?> :</h1>
</header>
<?= ($commentaires->rowCount() == 0) ? '<span style="color : green;">Pas encore de commentaires pour cet article.</span>' : '' ?>
<?php foreach ($commentaires as $commentaire): ?>
    <?php if ($commentaire['efface'] == '0') : ?>
        <p><a href="index.php?action=confirmer&id=<?= $commentaire['id'] ?>" >
                [Effacer]
            </a>
            <?= $commentaire['date'] ?>, <?= $commentaire['auteur'] ?> dit : (privé? <?= $commentaire['prive'] ?>)<br/>
            <strong><?= $commentaire['titre'] ?></strong><br/>
            <?= $commentaire['texte'] ?>
        </p>
    <?php endif; ?>
<?php endforeach; ?>

<form action="index.php?action=commentaire" method="post">
    <h2>Ajouter un commentaire</h2>
    <p>
        <label for="auteur">Courriel de l'auteur (xxx@yyy.zz)</label> : <input type="text" name="auteur" id="auteur" /> 
        <?= ($erreur == 'courriel') ? '<span style="color : red;">Entrez un courriel valide s.v.p.</span>' : '' ?> 
        <br />
        <label for="texte">Titre</label> :  <input type="text" name="titre" id="titre" /><br />
        <label for="texte">Commentaire</label> :  <textarea type="text" name="texte" id="texte" >Écrivez votre commentaire ici</textarea><br />
        <label for="prive">Privé?</label><input type="checkbox" name="prive" />
        <input type="hidden" name="article_id" value="<?= $article['id'] ?>" /><br />
        <input type="submit" value="Envoyer" />
    </p>
</form>


