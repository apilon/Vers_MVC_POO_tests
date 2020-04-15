<!-- Affichage -->
<!doctype html>
<html lang="fr">
    <head>
        <meta charset="UTF-8" />
        <link rel="stylesheet" href="Contenu/css/style.css" />
        <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/themes/base/minified/jquery-ui.min.css" type="text/css" />
        <title><?= $titre ?></title>   <!-- Élément spécifique -->
    </head>
    <body>
        <div id="global">
            <header>
                <a href="index.php"><h1 id="titreBlog">Le Blogue du prof v1.0.1.2</h1></a>
                <p>Version MVC en PHP orienté-objet avec tests.</p>
                <a href="index.php?action=apropos">
                    <h4>À propos</h4>
                </a>
                <a href="tests.php">
                    <h3>TESTS</h3>
                </a>
            </header>
            <?php
            if (isset($_SESSION['h204a4message']) and $_SESSION['h204a4message'] != "") {
                echo '<span style="color : red;">' . $_SESSION['h204a4message'] . '</span><br/>';
                $_SESSION['h204a4message'] = ""; // Le message n'est affiché qu'une seule fois
            }
            ?>
            <div id="contenu">
                <?= $contenu ?>   <!-- Élément spécifique -->
            </div> <!-- #contenu -->
            <footer id="piedBlog">
                Blog réalisé avec PHP, HTML5 et CSS.
            </footer>
        </div> <!-- #global -->
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.min.js"></script>
        <script type="text/javascript" src="Contenu/js/autocompleteType.js"></script>
    </body>
</html>



