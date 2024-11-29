<table class="table table-sm">
    <thead>
        <tr>
            <th colspan="2">Produto</th>
            <th>Preço</th>
        </tr>
    </thead>
    <tbody>
        <?php if (!empty($data['products'])): ?>
            <?php foreach ($data['products'] as $k => $v): ?>
                <tr>
                    <td><img class="object-fit-cover rounded-2" width="40" height="40" src="<?= $router->route('root') . '/assets/@img/' . $v['url_image'] ?>" alt=""></td>
                    <td>
                        <div class="h6"><?= $v['product'] ?></div>
                        <div><?= $v['short'] ?></div>
                        <div><?= $v['quantity'] . ' x <span class="cash-br">' . number_format($v['price'], 2, ',', '.') . '</span>' ?></div>
                        <div>
                            <button class="cart-remove btn btn-sm btn-danger" data-cp-item-id="<?= $v['id'] ?>" type="button">
                                <i class="fa fa-times"></i> Remover
                            </button>
                        </div>
                    </td>
                    <td class="text-end"><span class="cash-br h6"><?= number_format($v['total'], 2, ',', '.') ?></span></td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr>
                <td colspan="3" class="text-center">Carrinho vazio!</td>
            </tr>
        <?php endif; ?>
    </tbody>
    <tfoot>
        <tr class="table-secondary">
            <th colspan="2">Total</th>
            <td class="text-end"><span class="cash-br h5"><?= (!empty($data['total']) ? convertDecimalToCurrency($data['total']) : '0,00') ?></span></td>
        </tr>
    </tfoot>
</table>
<div class="d-grid gap-2">
    <?php if (empty($costumer) && empty($data['products'])): ?>
        <button id="cartBtnNext" class="btn btn-primary" type="button" disabled>Finalizar pedido</button>
    <?php endif; ?>
    <?php if (empty($costumer) && !empty($data['products'])): ?>
        <button id="cartBtnNext" class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#modalLogin">Finalizar pedido</button>
    <?php endif; ?>
    <?php if (!empty($costumer) && !empty($data['products'])): ?>
        <button id="cartBtnNext" class="btn btn-primary" type="button" data-bs-target="#modalOrder" data-bs-toggle="modal">Finalizar pedido</button>
    <?php endif; ?>
</div>