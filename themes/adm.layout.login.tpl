<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cupcake (Adm)</title>
    <link rel="stylesheet" href="<?= $router->route('start'); ?>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?= $router->route('start'); ?>/assets/css/style.css">
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('<?= $router->route('root') ?>/assets/img/frame2.jpg');
            background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
</head>

<body>

    <?= $this->section('content'); ?>

    <script src="<?= $router->route('start'); ?>/assets/js/jquery-3.7.1.min.js"></script>
    <script src="<?= $router->route('start'); ?>/assets/js/bootstrap.bundle.min.js"></script>
</body>

</html>