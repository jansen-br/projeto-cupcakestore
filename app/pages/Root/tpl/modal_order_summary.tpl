<!-- Modal Payment -->
<div class="modal fade" id="modalOrderSummary" tabindex="-1" aria-labelledby="modalOrderSummaryLabel">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/cart.svg" alt="" class="me-3">
                    <div class="h5 m-0">Resumo do Pedido</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <?= $this->insert('alert') ?>
            <div id="modalOrderSummaryBody" class="modal-body"></div>
        </div>
    </div>
</div>