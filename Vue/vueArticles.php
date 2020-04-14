<?php $this->titre = 'Le Blogue du prof'; ?>

<a href="index.php?action=nouvelArticle">
    <h2 class="titreArticle">Ajouter un article</h2>
</a>
<?php foreach ($articles as $article):
    ?>

    <article>
        <header>
            <a href="index.php?action=article&id=<?= $article['id'] ?>">
                <h1 class="titreArticle"><?= $article['titre'] ?></h1>
            </a>
            <strong class=""><?= $article['sous_titre'] ?></strong>
            <time><?= $article['date'] ?></time>, par utilisateur #<?= $article['utilisateur_id'] ?>
        </header>
        <p><?= $article['texte'] ?><br/>
            <em><?= $article['type'] ?></em>
            <a href="index.php?action=modifierArticle&id=<?= $article['id'] ?>"> [modifier l'article]</a>
        </p>
    </article>
    <hr />
<?php endforeach; ?>    
