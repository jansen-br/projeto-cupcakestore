<!-- Modal Payment -->
<div class="modal fade" id="modalCostumerPaymentMethod" tabindex="-1" aria-labelledby="modalCostumerPaymentMethodLabel">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/cart.svg" alt="" class="me-3">
                    <div class="h5 m-0">Formas de Pagamento</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div id="modalCostumerPaymentMethodBody" class="modal-body"></div>
            <?php if (!empty($cart)): ?>
                <div class="modal-footer border-0">
                    <a href="#" class="btn btn-primary w-100" data-bs-target="#modalOrder" data-bs-toggle="modal">Finalizar Pedido</a>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>