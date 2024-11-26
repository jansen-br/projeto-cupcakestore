<!-- Modal ORDER LIST -->
<div class="modal fade" id="modalOrderList" tabindex="-1" aria-labelledby="modalOrderListLabel" data-cp-frame-route="list.orders">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/cart.svg" alt="" class="me-3">
                    <div class="h5 m-0">Pedidos Realizados</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div id="modalOrderListBody" class="modal-body" data-cp-frame-content="order_list">
                <div id="order_{:id}" class="border p-2 mb-3">
                    <div class="row">
                        <div class="col-10">
                            <div>Número do pedido: <b>#{:number}</b></div>
                            <div>Data da compra: {:date_registry}</div>
                            <div>Status: {:status}</div>
                        </div>
                        <div class="col-2 d-flex justify-content-center align-items-center">
                            <a href="#" class="btn btn-primary rounded-circle" data-bs-toggle="modal" data-bs-target="#modalOrderSummary"><i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>