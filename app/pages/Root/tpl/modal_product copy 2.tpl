<!-- Modal Product -->
<div class="modal fade" id="modalProduct" tabindex="-1" aria-labelledby="modalProductLabel" data-cp-frame-route="product.get">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/cupcake.svg" alt="" class="me-3">
                    <div class="h5 m-0">Cupcake</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div class="modal-body">
                <div id="mdProductImage" class="mb-3"></div>
                <div id="mdProductName" class="h2 mb-0"></div>
                <div id="mdProductShort" class="mb-3"></div>
                <div class="accordion mb-3" id="accordionDescription">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDescription" aria-expanded="false" aria-controls="collapseTwo">
                                Descrição do produto
                            </button>
                        </h2>
                        <div id="collapseDescription" class="accordion-collapse collapse" data-bs-parent="#accordionDescription">
                            <div id="mdProductDescription" class="accordion-body"></div>
                        </div>
                    </div>
                </div>
                <form action="<?= (isset($action_cart_add) ? $action_cart_add : '') ?>" method="post">
                    <div id="mdProductAction" class="row justify-content-end align-items-center g-3 mb-3">
                        <div class="col-auto">
                            <label for="mdProductQuantity" class="col-form-label">Quantidade</label>
                        </div>
                        <div class="col-auto">
                            <input id="mdProductQuantity" class="form-control" type="number" name="quantity" min="1" max="20" value="1">
                        </div>
                        <div class="col-auto text-primary h4"><small>R$ </small><span id="mdProductPrice"></span></div>
                    </div>
                    <div class="text-end">
                        <button class="btn btn-primary"><i class="fa fa-plus-circle"></i> Adicionar ao carrinho</button>
                    </div>
                    <input id="mdProductId" type="hidden" name="id">
                    <input type="hidden" name="redirect" value="<?= (isset($redirect) ? $redirect : '') ?>">
                </form>
            </div>
        </div>
    </div>
</div>