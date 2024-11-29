<!-- Modal Payment -->
<div class="modal fade" id="modalCostumerPaymentMethod" tabindex="-1" aria-labelledby="modalCostumerPaymentMethodLabel" data-cp-frame-route="costumer.render.payment.method">
    <div class="modal-dialog modal-hd">
        <div class="modal-content">
            <div class="modal-header justify-content-between bg-cp-primary text-white">
                <div class="modal-title d-flex justify-content-start align-items-center">
                    <img width="32" height="32" src="<?= $router->route('root') ?>/assets/img/card.svg" alt="" class="me-3">
                    <div class="h5 m-0">Formas de Pagamento</div>
                </div>
                <button type="button" class="btn btn-light rounded-circle" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div id="modalCostumerPaymentMethodBody" class="modal-body">
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
                                    <div class="form-floating mb-3 positin-relative">
                                        <input name="number" type="text" class="form-control" id="PaymentMethodNumber" placeholder="Número do cartão de crédito" required>
                                        <label for="PaymentMethodNumber">Número</label>
                                        <div class="small position-absolute top-50 end-0 translate-middle">
                                            <div id="PaymentMethodFlagLabel" data-card-logo="unknown" class="creditcard-logo"></div>
                                            <input id="PaymentMethodFlag" name="flag" type="hidden">
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
                <script class="cp-template" type="x-tmpl-mustache">
                    {{#creditcard}}
                        <div id="creditCard_{{id}}" class="border p-2 mb-3">
                            <div class="row">
                                <div class="col-10">
                                    <div>{{number}}</div>
                                    <div data-card-logo="{{flag}}" class="creditcard-logo" title="{{flag}}"></div>
                                    <div class="small">
                                        <button
                                            class="btn btn-sm btn-danger"
                                            data-cp-method="DELETE"
                                            data-cp-target="#creditCard_{{id}}"
                                            data-cp-item-id="{{id}}"
                                            data-cp-route="costumer.remove.creditcard">Remover</button>
                                    </div>
                                </div>
                                <div class="col-2 d-flex justify-content-center align-items-center">
                                    <input class="form-check-input" data-cp-creditcard-id="{{id}}" type="radio" name="prefered" {{#prefered}}checked{{/prefered}}>
                                </div>
                            </div>
                        </div>
                    {{/creditcard}}
                    {{^creditcard}}
                        <div class="border p-2 mb-3 text-center">Nenhum cartão de crédito registrado!</div>
                    {{/creditcard}}
                </script>
                <div class="placeholder-glow" aria-hidden="true">
                    <script>
                        for (let i = 0; i < 3; i++) {
                            document.write(
                                '<div class="border p-2 mb-3">' +
                                '<div><span class="placeholder col-6"></span></div>' +
                                '<div><span class="placeholder col-8"></span></div>' +
                                '<div><span class="placeholder col-4"></span></div>' +
                                '<div><a href="#" class="btn btn-primary disabled placeholder col-6" aria-disabled="true"></a></div>' +
                                '</div>');
                        }
                    </script>
                </div>
                <div class="cp-render"></div>
            </div>
            <?php if (!empty($cart)): ?>
                <div class="modal-footer border-0">
                    <a href="#" class="btn btn-primary w-100" data-bs-target="#modalOrder" data-bs-toggle="modal">Finalizar Pedido</a>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>