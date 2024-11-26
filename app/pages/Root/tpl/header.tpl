<div class="container rounded-cp-bottom text-white">
    <div id="cpMenu" class="row position-relative">
        <div class="col p-2">
            <img id="cpBrand" src="<?= $router->route('root'); ?>/assets/img/logo.svg" alt="">
        </div>
        <div class="col d-flex justify-content-end align-items-center gap-2">
            <div id="cpCart">
                <a id="cpCartLink" href="<?= $router->route('root.render.cart'); ?>" class="position-relative" data-bs-toggle="modal" data-bs-target="#modalCart">
                    <img class="" src="<?= $router->route('root'); ?>/assets/img/cart.svg" alt="">
                    <?php if (!empty($cart)): ?>
                        <span id="cpCartBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><?= count($cart) ?>+</span>
                    <?php endif; ?>
                </a>
            </div>
            <div id="cpUser">
                <?php if (empty($costumer)): ?>
                    <a id="cpUserBtn" href="#" class="" data-bs-toggle="modal" data-bs-target="#modalLogin">
                        <img class="" src="<?= $router->route('root'); ?>/assets/img/user.svg" alt="">
                    </a>
                <?php else: ?>
                    <a id="cpUserBtn" href="#" class="" data-bs-toggle="offcanvas" data-bs-target="#offCostumer"">
                        <img class=" bg-primary rounded-circle" src="<?= $router->route('root'); ?>/assets/img/user.svg" alt="">
                    </a>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>