<div class="offcanvas offcanvas-end text-bg-dark" tabindex="-1" id="offCostumer" aria-labelledby="offCostumerLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offCostumerLabel">Offcanvas</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">

        <div class="d-grid gap-2 mb-2">
            <a href="#" id="itemCostumerAddress" class="btn btn-outline-light" data-bs-target="#modalCostumerAddress" data-bs-toggle="modal">Endereço de Entrega</a>
        </div>
        <div class="d-grid gap-2 mb-2">
            <a href="#" id="itemCostumerPaymentMethod" class="btn btn-outline-light" data-bs-target="#modalCostumerPaymentMethod" data-bs-toggle="modal">Formas de Pagamento</a>
        </div>
        <div class="d-grid gap-2 mb-2">
            <a href="#" id="itemOrderSummary" class="btn btn-outline-light" data-bs-target="#modalOrderSummary" data-bs-toggle="modal">Resumo do pedido</a>
        </div>
        <div class="d-grid gap-2 mb-2">
            <a href="<?= $router->route('costumer.leave') ?>" class="btn btn-outline-light">Sair</a>
        </div>
    </div>
</div>