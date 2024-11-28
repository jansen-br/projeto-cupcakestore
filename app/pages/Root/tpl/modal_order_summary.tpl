<!-- Modal Payment -->
<div class="modal fade" id="modalOrderSummary" tabindex="-1" aria-labelledby="modalOrderSummaryLabel" data-cp-frame-route="render.order.summary">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/order.svg" alt="" class="me-3">
                    <div class="h5 m-0">Resumo do Pedido</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div id="modalOrderSummaryBody" class="modal-body">
                <script class="cp-template" type="x-tmpl-mustache">
                    <div>
                    <div>
                        <div class="h6">Pedido #<span>{{order.number}}</span></div>
                        <div>Data: <span class="datetime">{{order.date_registry}}</span></div>
                        <div>Status: <span class="text-primary">{{order.status}}</span></div>
                    </div>
                    </div>
                     <hr>
                
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Produto</th>
                                <th>Qt.</th>
                                <th class="text-end">Valor</th>
                            </tr>
                        </thead>
                        <tbody data-cp-frame-content="order_items">
                        {{#order_items}}    
                        <tr>
                                <td>
                                    <div><span>{{product}}</span></div>
                                    <div class="small"><span>{{short}}</span></div>
                                </td>
                                <td><span>{{quantity}}</span></td>
                                <td class="text-end"><span class="cash-br">{{price}}</span></td>
                        </tr>
                        {{/order_items}}
                        </tbody>
                        <tfoot data-cp-frame-content="total">
                            <tr>
                                <th colspan="2">Valor total do pedido</th>
                                <td class="h5 text-end"><span class="cash-br">{{order.total_amount}}</span></td>
                            </tr>
                        </tfoot>
                    </table>
                </script>
                <div class="placeholder-glow" aria-hidden="true">
                    <script>
                        document.write(
                            '<div>' +
                            '<div><span class="placeholder col-6"></span></div>' +
                            '<div><span class="placeholder col-8"></span></div>' +
                            '<div><span class="placeholder col-4"></span></div>' +
                            '</div>'
                        );
                    </script>
                </div>
                <div class="cp-render"></div>
            </div>
        </div>
    </div>
</div>