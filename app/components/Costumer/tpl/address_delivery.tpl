<div class="accordion accordion-flush border" id="accordionCostumerAddress">
    <div class="accordion-item">
        <h2 class="accordion-header">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                <i class="fa fa-plus-circle h4 me-3 my-0"></i>Acrescentar endereço de entrega
            </button>
        </h2>
        <div id="flush-collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionCostumerAddress">
            <div class="accordion-body">
                <form action="<?= $router->route('costumer.registre.address.delivery') ?>" method="post">
                    <div class="form-floating mb-3">
                        <input name="address" type="text" class="form-control" id="address" placeholder="" required>
                        <label for="address">Endereço</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input name="neighborhood" type="text" class="form-control" id="neighborhood" placeholder="" required>
                        <label for="neighborhood">Bairro</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input name="city" type="text" class="form-control" id="city" placeholder="" required>
                        <label for="city">Cidade</label>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-floating mb-3">
                                <input name="state" type="text" class="form-control" id="state" placeholder="" required>
                                <label for="state">Estado</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="form-floating mb-3">
                                <input name="postal_code" type="text" class="form-control" id="postal_code" placeholder="" required>
                                <label for="postal_code">CEP</label>
                            </div>
                        </div>
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
<h6>Endereços registrados:</h6>
<?php $count = 0; ?>
<?php if (!empty($addresses)): ?>
    <?php foreach ($addresses as $v): ?>
        <div id="addressNumb_<?= $count ?>" class="border p-2 mb-3">
            <div class="row">
                <div class="col-10">
                    <div>
                        <?= $v['address'] ?>
                    </div>
                    <div class="small mb-1">
                        <span class="me-2">
                            <?= $v['neighborhood'] ?>, <?= $v['city'] ?> - <?= $v['state'] ?>
                        </span>
                        <span>
                            <?= $v['postal_code'] ?>
                        </span>
                    </div>
                    <div class="small">
                        <button class="remove-address btn btn-sm btn-danger" data-cp-target="#addressNumb_<?= $count ?>" data-cp-address-id="<?= $v['id'] ?>">Remover</button>
                    </div>
                </div>
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <input class="form-check-input" data-cp-address-id="<?= $v['id'] ?>" type="radio" name="prefered" <?= ($v['prefered'] == 1 ? 'checked' : '') ?>>
                </div>
            </div>
        </div>
        <?php $count++; ?>
    <?php endforeach; ?>
<?php else: ?>
    <div class="border p-2 mb-3">
        Nenhum endereço registrado.
    </div>
<?php endif; ?>