<h6>Valor total do pedido</h6>
<h3 class="cash-br text-end mb-3"><?= (!empty($cart['total']) ? convertDecimalToCurrency($cart['total']) : '0,00') ?></h3>
<h6>Endereço de entrega</h6>
<div>
    <?php if (empty($address)): ?>
        <div class="border p-2">
            <div>Nenhum registro!</div>
            <button class="btn btn-link px-0" data-bs-target="#modalCostumerAddress" data-bs-toggle="modal">Cadastrar endereço</button>
        </div>
    <?php else: ?>
        <div class="row m-0 border">
            <div class="col-1 d-flex align-items-center"><i class="fa fa-check h5 text-success"></i></div>
            <div class="col-11">
                <div>
                    <?= $address['address'] ?>
                </div>
                <div class="small mb-1">
                    <span class="me-2">
                        <?= $address['neighborhood'] ?>, <?= $address['city'] ?> - <?= $address['state'] ?>
                    </span>
                    <span>
                        <?= $address['postal_code'] ?>
                    </span>
                </div>
                <div class="small">
                    <button class="btn btn-sm btn-link px-0" data-bs-target="#modalCostumerAddress" data-bs-toggle="modal">Mudar endereço de entrega</button>
                </div>
            </div>
        </div>
    <?php endif; ?>
</div>
<hr>
<h6>Forma de pagamento</h6>
<div>
    <?php if (empty($creditcard)): ?>
        <div class="border p-2">
            <div>Nenhum registro!</div>
            <button class="btn btn-link px-0" data-bs-target="#modalCostumerPaymentMethod" data-bs-toggle="modal">Cadastrar forma de pagamento</button>
        </div>
    <?php else: ?>
        <div class="row m-0 border">
            <div class="col-1 d-flex align-items-center"><i class="fa fa-check h5 text-success"></i></div>
            <div class="col-11">
                <div>
                    <?= $creditcard['number'] ?>
                </div>
                <div class="small mb-1">
                    <?= $creditcard['flag'] ?>
                </div>
                <div class="small">
                    <button class="btn btn-sm btn-link px-0" data-bs-target="#modalCostumerPaymentMethod" data-bs-toggle="modal">Mudar forma de pagamento</button>
                </div>
            </div>
        </div>
    <?php endif; ?>
</div>
<div class="row m-0">
    <div class="col-md-6 p-3"><button class="btn btn-outline-primary w-100" data-bs-target="#modalCart" data-bs-toggle="modal">Cancelar</button></div>
    <div class="col-md-6 p-3">
        <form action="<?= (empty($creditcard) || empty($creditcard)) ? '#' : $router->route('finalize.order') ?>" method="post">
            <button type="<?= (empty($creditcard) || empty($creditcard)) ? 'button' : 'submit' ?>" class="btn btn-primary w-100" <?= (empty($creditcard) || empty($creditcard)) ? 'disabled' : '' ?>>Confirmar</button>
        </form>
    </div>
</div>