<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cupcake (Adm)</title>
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/all.min.css">
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/dataTables.bootstrap5.css" />
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="<?= $router->route('root'); ?>/assets/css/richtext.min.css" />
    <?= $this->section('css') ?>
</head>

<body>
    <header>
        <div id="menu">
            <div class="p-2 border-bottom">
                <button class="btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling" title="Menu">
                    <img width="32px" height="32px" src="<?= $router->route('root'); ?>/assets/img/menu.svg" alt="">
                </button>
                <a href="<?= $router->route('root') ?>" class="btn pb-0 mb-0" title="<?= $router->route('root') ?>"><i class="fa fa-eye h4"></i></a>
            </div>
        </div>

        <div class="offcanvas offcanvas-start" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
            <div class="offcanvas-header">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <nav>
                    <div class="d-grid gap-2">
                        <a href="<?= $router->route('manager.products') ?>" class="btn btn-outline-dark">Produtos</a>
                        <a href="<?= $router->route('auth.leave', ['redirect' => 'manager.login']) ?>" class="btn btn-outline-dark">Sair</a>
                    </div>
                </nav>
            </div>
        </div>
    </header>
    <article class="p-2">
        <div id="cpAlert">
            <?= $this->insert('alert') ?>
        </div>
        <?= $this->section('content'); ?>
    </article>

    <!-- jquery js -->
    <script src="<?= $router->route('root'); ?>/assets/js/jquery-3.7.1.min.js"></script>
    <!-- jquery mask js -->
    <script src="<?= $router->route('root'); ?>/assets/js/jquery.mask.min.js"></script>
    <!-- bootstrap js -->
    <script src="<?= $router->route('root'); ?>/assets/js/popper.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/bootstrap.validation.js"></script>
    <!-- datatables js -->
    <script src="<?= $router->route('root'); ?>/assets/js/jquery.dataTables.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/moment.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/dataTables.bootstrap5.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/dataTables.rowGroup.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/dataTables.buttons.min.js"></script>
    <!-- JS RICHTEXT -->
    <script src="<?= $router->route('root'); ?>/assets/js/jquery.richtext.min.js"></script>
    <script src="<?= $router->route('root'); ?>/assets/js/jquery.richtext-pt-br.js"></script>
    <!-- JS CONVERTERS -->
    <script src="<?= $router->route('root'); ?>/assets/js/converters.js"></script>
    <!-- SECTION JS -->
    <?= $this->section('js') ?>
</body>

</html>