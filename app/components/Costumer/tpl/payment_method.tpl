<div class="accordion accordion-flush border" id="accordionPaymentMethod">
    <div class="accordion-item">
        <h2 class="accordion-header">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                <i class="fa fa-plus-circle h4 me-3 my-0"></i>Acrescentar cartão de crédito
            </button>
        </h2>
        <div id="flush-collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionPaymentMethod">
            <div class="accordion-body">
                <form action="<?= $router->route('costumer.registre.creditcard') ?>" method="post">
                    <div class="form-floating mb-3">
                        <input name="number" type="text" class="form-control" id="PaymentMethodNumber" placeholder="Número do cartão de crédito" required>
                        <label for="PaymentMethodNumber">Número</label>
                    </div>
                    <div class="small">
                        <div id="PaymentMethodFlagLabel"></div>
                        <input id="PaymentMethodFlag" name="flag" type="hidden">
                    </div>
                    <!-- Submit button -->
                    <div class="d-grid gap-2">
                        <input type="hidden" name="_method" value="PUT">
                        <button type="submit" class="btn btn-primary btn-block mb-4">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<hr>
<h6>Cartões de crédito registrados:</h6>
<?php $count = 0; ?>
<?php if (!empty($creditcards)): ?>
    <?php foreach ($creditcards as $v): ?>
        <div id="creditCard_<?= $count ?>" class="border p-2 mb-3">
            <div class="row">
                <div class="col-10">
                    <div>
                        <?= $v['number'] ?>
                    </div>
                    <div>
                        <?= $v['flag'] ?>
                    </div>
                    <div class="small">
                        <button
                            class="btn btn-sm btn-danger"
                            data-cp-method="DELETE" 
                            data-cp-target="#creditCard_<?= $count ?>"
                            data-cp-item-id="<?= $v['id'] ?>"
                            data-cp-route="costumer.remove.creditcard">Remover</button>
                    </div>
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <input class="form-check-input" data-cp-creditcard-id="<?= $v['id'] ?>" type="radio" name="prefered" <?= ($v['prefered'] == 1 ? 'checked' : '') ?>>
                </div>
            </div>
        </div>
        <?php $count++; ?>
    <?php endforeach; ?>
<?php else: ?>
    <div class="border p-2 mb-3">
        Nenhum registrado.
    </div>
<?php endif; ?>