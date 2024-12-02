<!DOCTYPE html>
<html lang="en">

<head>
    <base href="/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cupcake</title>
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/all.min.css">
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/style.css">
    <?= $this->section('css'); ?>
</head>

<body>
    <!-- <div id="cpHeader" class="position-absolute w-100" style="z-index: 10;"> -->
        <?= $this->section('header') ?>
    <!-- </div> -->
    <div id="cpBody">
        <?= $this->section('content') ?>
    </div>
    <div id="cpFooter">
        <footer class="text-center text-lg-start">
            <div class="text-center p-3 bg-cp-accent-100">
                © 2024 Copyright:
                <a class="text-body" href="#">Jansen Lira</a>
            </div>
        </footer>
    </div>

    <!-- JS JQUERY -->
    <script src="<?= $router->route('root'); ?>/assets/js/jquery-3.7.1.min.js"></script>
    <!-- jquery mask js -->
    <script src="<?= $router->route('root'); ?>/assets/js/jquery.mask.min.js"></script>
    <!-- JS BOOTSTRAP -->
    <script src="<?= $router->route('root'); ?>/assets/js/bootstrap.bundle.min.js"></script>
    <?= $this->section('js'); ?>
</body>

</html>