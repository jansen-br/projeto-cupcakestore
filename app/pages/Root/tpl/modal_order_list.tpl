<!-- Modal ORDER LIST -->
<div class="modal fade" id="modalOrderList" tabindex="-1" aria-labelledby="modalOrderListLabel" data-cp-frame-route="list.orders">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/list.svg" alt="" class="me-3">
                    <div class="h5 m-0">Pedidos Realizados</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div id="modalOrderListBody" class="modal-body">
                <script class="cp-template" type="x-tmpl-mustache">
                    {{#order_list}}
                        <div id="order_{{id}}" class="border p-2 mb-3">
                            <div class="row">
                                <div class="col-10">
                                    <div>Número do pedido: <span class="fw-bold">#{{number}}</span></div>
                                    <div>Data da compra: <span class="datetime">{{date_registry}}</span></div>
                                    <div data-status="{{status}}">Status: <span>{{status}}</span></div>
                                </div>
                                <div class="col-2 d-flex justify-content-center align-items-center">
                                    <a href="#" class="btn btn-primary rounded-circle" data-cp-order-id="{{id}}" data-bs-toggle="modal" data-bs-target="#modalOrderSummary"><i class="fa fa-arrow-right"></i></a>
                                </div>
                            </div>
                        </div>
                    {{/order_list}}
                    {{^order_list}}
                        <div class="border p-2 mb-3 text-center">Nenhum pedido registrado!</div>
                    {{/order_list}}
                </script>
                <div class="placeholder-glow" aria-hidden="true">
                    <script>
                        for (let i = 0; i < 3; i++) {
                            document.write(
                                '<div class="border p-2 mb-3">' +
                                '<div class="row">' +
                                '<div class="col-10">' +
                                '<div><span class="placeholder col-6"></span></div>' +
                                '<div><span class="placeholder col-8"></span></div>' +
                                '<div><span class="placeholder col-4"></span></div>' +
                                '</div>' +
                                '<div class="col-2 d-flex justify-content-center align-items-center placeholder-glow">' +
                                '<a href="#" class="btn btn-primary rounded-circle disabled placeholder" aria-disabled="true"><i class="fa fa-arrow-right"></i></a>' +
                                '</div>' +
                                '</div>' +
                                '</div>');
                        }
                    </script>
                </div>
                <div class="cp-render"></div>
            </div>

        </div>
    </div>
</div>