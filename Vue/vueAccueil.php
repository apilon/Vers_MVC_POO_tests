<?php $titre = 'Le Blogue du prof'; ?>

<?php ob_start(); ?>

<a href="index.php?action=nouvelArticle">
    <h2 class="titreArticle">Ajouter un article</h2>
</a>
<?php foreach ($articles as $article):
    ?>

    <article>
        <header>
            <a href="<?= "index.php?action=article&id=" . $article['id'] ?>">
                <h1 class="titreArticle"><?= $article['titre'] ?></h1>
            </a>
            <h3 class=""><?= $article['sous_titre'] ?></h3>
            <time><?= $article['date'] ?></time>, par utilisateur #<?= $article['utilisateur_id'] ?>
        </header>
        <p><?= $article['texte'] ?></p>
        <p><?= $article['type'] ?></p>
    </article>
    <hr />
<?php endforeach; ?>    
<?php $contenu = ob_get_clean(); ?>

<?php require 'Vue/gabarit.php'; ?>