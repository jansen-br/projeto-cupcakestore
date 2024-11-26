<!-- Modal Payment -->
<div class="modal fade" id="modalOrderSummary" tabindex="-1" aria-labelledby="modalOrderSummaryLabel" data-cp-frame-route="render.order.summary">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/cart.svg" alt="" class="me-3">
                    <div class="h5 m-0">Resumo do Pedido</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div id="modalOrderSummaryBody" class="modal-body">
                <div data-cp-frame-content="order">
                    <div class="h6">Pedido #{:number}</div>
                    <div>Data: {:date_registry}</div>
                    <div>Status: <span class="text-primary">{:status}</span></div>
                    <hr>
                    <div class="fw-bold text-end mb-3">Valor total do pedido</div>
                    <h5 class="cash-br text-end">{:total_amount}</h5>
                </div>
                <hr>
                <div>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Produto</th>
                                <th>Qt.</th>
                                <th class="text-end">Valor</th>
                            </tr>
                        </thead>
                        <tbody data-cp-frame-content="order_items">
                            <tr>
                                <td>
                                    <div>{:product}</div>
                                    <div class="small">{:short}</div>
                                </td>
                                <td>{:quantity}</td>
                                <td class="text-end"><span class="cash-br">{:price}</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>