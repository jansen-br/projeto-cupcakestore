<?php

$this->layout('app.layout', ['title' => 'Principal']);


$this->start('header');
$this->insert('root::header');
$this->stop();

?>

<?php $this->start('css'); ?>
<style>
    .cash-br::before {
        content: 'R$';
        margin-right: 5px;
        font-size: 0.7em;
    }

    .cp-placeholder span {
        display: inline-block;
        min-height: 1em;
        vertical-align: middle;
        cursor: wait;
        background-color: currentcolor;
        opacity: .5;
        animation: place-holder 2s ease-in-out infinite;
        animation-duration: 2s;
        animation-timing-function: ease-in-out;
        animation-delay: 0s;
        animation-iteration-count: infinite;
        animation-direction: normal;
        animation-fill-mode: none;
        animation-play-state: running;
        animation-name: placeholder-glow;
        animation-timeline: auto;
        animation-range-start: normal;

    }

    *[data-status] span {
        display: none;
    }


    *[data-status="'pending"]:after {
        content: 'pendente';
    }

    *[data-status="paid"]:after {
        content: 'pago';
    }

    *[data-status="shipped"]:after {
        content: 'Enviado';
    }

    *[data-status="delivered"]:after {
        content: 'entregue';
    }

    *[data-status="cancelled"]:after {
        content: 'cancelado';
    }

    *[data-status]::after {
        text-transform: capitalize;
    }

    div.creditcard-logo {
        width: 32px;
        height: 32px;
        background-repeat: no-repeat;
        background-size: cover;
    }

    div.creditcard-logo[data-card-logo="unknown"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-unknown.jpg');
    }

    div.creditcard-logo[data-card-logo="visa"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-visa.jpg');
    }

    div.creditcard-logo[data-card-logo="mastercard"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-mastercard.jpg');
    }

    div.creditcard-logo[data-card-logo="elo"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-elo.jpg');
    }

    div.creditcard-logo[data-card-logo="amex"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-amex.jpg');
    }

    div.creditcard-logo[data-card-logo="diners_club"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-diners_club.jpg');
    }

    div.creditcard-logo[data-card-logo="discover"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-discover.jpg');
    }

    div.creditcard-logo[data-card-logo="jcb"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-jcb.jpg');
    }

    div.creditcard-logo[data-card-logo="nubank"] {
        background-image: url('<?= $router->route('root') ?>/assets/img/card-nubank.jpg');
    }


    @keyframes place-holder {
        50% {
            opacity: .2;
        }
    }

    /* 'unknown','visa','mastercard','elo','amex','diners_club','discover','jcb' */
</style>
<?php $this->stop(); ?>

<?php $this->insert('root::carousel'); ?>

<article class="container">
    <a href="#" data-bs-target="modalAlert" data-bs-toggle="modal">Test</a>
    <?php $this->insert('root::tools'); ?>

    <div id="products" class="row"></div>

    <?php
    if (empty($costumer)) {
        $this->insert('root::modal_login');
    } else {
        $this->insert('root::menu_costumer');
    }

    ?>
</article>

<?php $this->insert('root::modal_alert'); ?>
<?php $this->insert('root::modal_product'); ?>
<?php $this->insert('root::modal_cart'); ?>
<?php $this->insert('root::modal_order'); ?>
<?php $this->insert('root::modal_costumer_address'); ?>
<?php $this->insert('root::modal_costumer_payment_method'); ?>
<?php $this->insert('root::modal_order_summary'); ?>
<?php $this->insert('root::modal_order_list'); ?>

<?php $this->start('js'); ?>
<script src="<?= $router->route('root') ?>/assets/js/cp.productDataList.js"></script>
<script src="<?= $router->route('root') ?>/assets/js/mustache.js"></script>
<script>
    /** DATALIST */
    const url_products_list = '<?= $router->route('product.list'); ?>';

    let products = new ProductDataList(
        $('#products'), {
            url: url_products_list,
            folder_image: '<?= $router->route('root'); ?>/assets/@img/',
            columns: [{
                    data: 'products'
                },
                {
                    data: 'prices'
                }
            ]
        }
    )

    /** MODAL PRODUCT */
    const modalProduct = document.getElementById('modalProduct');
    const url_get_product = '<?= $router->route('product.get') ?>';
    const folder_image = '<?= $router->route('root'); ?>/assets/@img/';

    if (modalProduct) {
        modalProduct.addEventListener('show.bs.modal', event => {
            const button = event.relatedTarget;
            const modalProductLabel = document.getElementById('modalProductLabel');
            const mdProductImage = document.getElementById('mdProductImage');
            const mdProductName = document.getElementById('mdProductName');
            const mdProductShort = document.getElementById('mdProductShort');
            const mdProductDescription = document.getElementById('mdProductDescription');
            const mdProductId = document.getElementById('mdProductId');
            const mdProductQuantity = document.getElementById('mdProductQuantity');
            const mdProductPrice = document.getElementById('mdProductPrice');

            let productsId = button.dataset.cpId;

            mdProductName.innerText = "";
            mdProductImage.innerHTML = "";
            mdProductDescription.innerHTML = "";
            mdProductId.value = 0;
            mdProductQuantity.value = 1;


            $.ajax({
                url: url_get_product,
                data: {
                    id: productsId
                },
                method: 'POST',
                success: function(response) {
                    mdProductId.value = response.id;
                    mdProductName.innerText = response.product;
                    mdProductImage.innerHTML = (
                        '<img src="' + folder_image + '/' + response.images[0].url_image + '" class="img-fluid rounded-3" >'

                    );
                    mdProductShort.innerHTML = response.short;
                    mdProductDescription.innerHTML = response.description;
                    mdProductPrice.innerHTML = convertDecimalToCurrencyBR(response.price);

                    /** CHANGE PRICE */
                    mdProductQuantity.addEventListener('change', (e) => {
                        let qnt = e.target.value;
                        let entry = (qnt * (response.price)).toFixed(2);
                        mdProductPrice.innerHTML = convertDecimalToCurrencyBR(entry);
                    });
                },
                error: function(xhr, status, error) {
                    console.error(`Error: ${error}`);
                }
            });


        })
    }

    $('.input-email').mask("A", {
        translation: {
            "A": {
                pattern: /[\w@\-.+]/,
                recursive: true
            }
        }
    });

    $('.input-phone').mask("(99) 99999-9999");

    function convertDecimalToCurrencyBR(entry) {
        entry = entry.toString();
        return entry.replace('.', ',');
    }

    /** MODAL CART */
    const modalCart = document.getElementById('modalCart');
    const cpCartBadge = document.getElementById('cpCartBadge');
    const modalCartBody = document.getElementById('modalCartBody');
    const url_cart_show = '<?= $router->route('cart.show') ?>';
    const url_cart_remove = '<?= $router->route('cart.remove') ?>';

    modalCart.addEventListener('show.bs.modal', event => {
        showItems(url_cart_show);
    });

    modalCart.addEventListener('hidden.bs.modal', event => {
        modalCartBody.innerHTML = '';
    });

    function showItems(url) {
        $.ajax({
            url: url,
            method: 'POST',
            success: function(response) {

                modalCartBody.innerHTML = response;

                document.querySelectorAll('.cart-remove').forEach((button) => {
                    button.addEventListener('click', (e) => {
                        removeItem(e.target.dataset.cpItemId);
                    });
                });
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    }

    function removeItem(id) {
        if (id) {
            $.ajax({
                url: url_cart_remove,
                data: {
                    id: id
                },
                method: 'POST',
                success: function(response) {
                    if (response.removed == true) {
                        showItems(url_cart_show);
                        if (response.count > 0) {
                            cpCartBadge.innerText = response.count + '+';
                        } else {
                            bootstrap.Modal.getInstance(modalCart).hide();
                            cpCartBadge.remove();
                            document.getElementById('modalCartForm').remove();
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.error(`Error: ${error}`);
                }
            });
        }
    }

    /** MODAL ORDER */
    const modalOrder = document.getElementById('modalOrder');
    const url_order = getUrlRoute('render.order');
    modalOrder.addEventListener('show.bs.modal', event => {
        showOrder(url_order);
    });

    function showOrder(url) {
        if (!url) {
            return false;
        }

        $.ajax({
            url: url,
            method: 'POST',
            success: function(response) {
                modalOrder.querySelector('.modal-body').innerHTML = response;
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    }

    /** MODAL COSTUMER ADDRESS */
    const modalCostumerAddress = document.getElementById('modalCostumerAddress');
    const url_CostumerAddress = '<?= $router->route('costumer.render.address.delivery') ?>';
    modalCostumerAddress.addEventListener('show.bs.modal', event => {
        showCostumerAddress(url_CostumerAddress);
    });

    function showCostumerAddress(url) {
        if (!url) {
            return false;
        }

        $.ajax({
            url: url,
            method: 'POST',
            success: function(response) {
                modalCostumerAddress.querySelector('.modal-body').innerHTML = response;
                eventSetPreferedAddress();
                eventRemoveAddress();
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    }
    /** EVENT SET FREFERED ADDRESS */
    const url_PreferedAddress = '<?= $router->route('costumer.set.prefered.address') ?>';

    function eventSetPreferedAddress() {
        document.querySelectorAll('input[name="prefered"]').forEach(el => {
            el.addEventListener('change', function() {
                const address_id = this.dataset.cpAddressId;
                $.ajax({
                    url: url_PreferedAddress,
                    method: 'POST',
                    data: {
                        address_id: address_id
                    },
                    success: response => console.log(response),
                    error: function(xhr, status, error) {
                        console.error(`Error: ${error}`);
                    }
                });

            });
        });
    }
    /** EVENT REMOVE ADDRESS */
    const url_RemoveAddress = '<?= $router->route('costumer.remove.address') ?>';

    function eventRemoveAddress() {
        document.querySelectorAll('button.remove-address').forEach(el => {
            el.addEventListener('click', function() {
                const address_id = this.dataset.cpAddressId;
                const target = this.dataset.cpTarget;
                $.ajax({
                    url: url_RemoveAddress,
                    method: 'POST',
                    data: {
                        address_id: address_id,
                        _method: 'DELETE'
                    },
                    success: response => {
                        if (response.return == true) {
                            removeElement(target);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error(`Error: ${error}`);
                    }
                });
            });
        });
    }

    /** MODAL PAYMENT METHOD */
    document.getElementById('modalCostumerPaymentMethod').addEventListener('show.bs.modal', event => {
        let btn = event.relatedTarget;
        let target = event.target;
        let route = target.dataset.cpFrameRoute;

        $.ajax({
            url: getUrlRoute(route),
            method: 'POST',
            success: response => {
                console.log(response);

                const template = target.querySelector('.cp-template').innerHTML;
                const rendered = Mustache.render(template, response);
                target.querySelector('.cp-render').innerHTML = rendered;
                target.querySelector('.placeholder-glow').style.display = 'none';

                eventSetPreferedCreditCard(
                    target.querySelectorAll('input[name="prefered"]'),
                    'costumer.set.prefered.creditcard'
                );

                eventRemoveItem(
                    target.querySelectorAll('button[data-cp-method]'),
                    'costumer.remove.creditcard'
                );

                $('#PaymentMethodNumber').keyup((el) => {
                    if (el.target.value.length <= 16) {
                        let brand = getCardBrand(el.target.value);
                        console.log(brand);
                        document.getElementById('PaymentMethodFlag').value = brand;
                        document.getElementById('PaymentMethodFlagLabel').dataset.cardLogo = brand;
                    } else {
                        return false;
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    });

    function showCostumerPaymentMethod(url, elem) {
        if (!url || !elem) {
            return false;
        }

        $.ajax({
            url: url,
            method: 'POST',
            success: function(response) {
                modalCostumerPaymentMethod.querySelector('.modal-body').innerHTML = response;
                $('#PaymentMethodNumber').mask('9999999999999999').blur((el) => {
                    if (el.target.value.length == 16) {
                        let brand = getCardBrand(el.target.value);
                        console.log(brand);
                        document.getElementById('PaymentMethodFlag').value = brand;
                        document.getElementById('PaymentMethodFlagLabel').innerHTML = brand;
                    }
                });
                eventSetPreferedCreditCard();
                eventRemoveItem(
                    '#modalCostumerPaymentMethod button[data-cp-method]',
                    'costumer.remove.creditcard'
                );
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    }

    function eventSetPreferedCreditCard(elems, route) {
        elems.forEach(el => {
            el.addEventListener('change', function() {
                const creditcard_id = this.dataset.cpCreditcardId;
                $.ajax({
                    url: getUrlRoute(route),
                    method: 'POST',
                    data: {
                        creditcard_id: creditcard_id
                    },
                    success: response => console.log(response),
                    error: function(xhr, status, error) {
                        console.error(`Error: ${error}`);
                    }
                });
            });
        });
    }


    function eventRemoveItem(elems, route) {
        elems.forEach(el => {
            el.addEventListener('click', function() {
                let id = this.dataset.cpItemId;
                let target = this.dataset.cpTarget;
                let route = this.dataset.cpRoute;
                let method = this.dataset.cpMethod;

                $.ajax({
                    url: getUrlRoute(route),
                    method: 'POST',
                    data: {
                        id: id,
                        _method: method
                    },
                    success: response => {
                        if (response.return == true) {
                            removeElement(target);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error(`Error: ${error}`);
                    }
                });
            });
        });
    }

    function getUrlRoute(key) {
        const routes = [{
                'costumer.render.payment.method': '<?= $router->route('costumer.render.payment.method') ?>'
            },
            {
                'costumer.remove.creditcard': '<?= $router->route('costumer.remove.creditcard') ?>'
            },
            {
                'costumer.set.prefered.creditcard': '<?= $router->route('costumer.set.prefered.creditcard') ?>'
            },
            {
                'render.order': '<?= $router->route('render.order') ?>'
            },
            {
                'finalize.order': '<?= $router->route('finalize.order') ?>'
            },
            {
                'render.order.summary': '<?= $router->route('render.order.summary') ?>'
            },
            {
                'list.orders': '<?= $router->route('list.orders') ?>'
            }
        ];

        for (let url of routes) {
            if (url.hasOwnProperty(key)) {
                return url[key];
            }
        }
    }

    /** MODAL ORDER SUMMARY */
    document.getElementById('modalOrderSummary').addEventListener('show.bs.modal', event => {
        let btn = event.relatedTarget;
        let order_id = btn.dataset.cpOrderId;
        let target = event.target;
        let route = target.dataset.cpFrameRoute;

        let data = {
            'order_id': order_id
        };

        $.ajax({
            url: getUrlRoute(route),
            method: 'POST',
            data: data,
            success: response => {
                console.log(response);

                const template = target.querySelector('.cp-template').innerHTML;
                const rendered = Mustache.render(template, response);
                target.querySelector('.cp-render').innerHTML = rendered;
                target.querySelector('.placeholder-glow').style.display = 'none';
                $('.cp-render .cash-br', target).mask('9999,00');
                $('.cp-render .datetime', target).each(function() {
                    let originalDatetime = $(this).text();
                    let formattedDatetime = convertDatetime(originalDatetime);
                    $(this).text(formattedDatetime);
                });
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    });

    document.getElementById('modalOrderSummary').addEventListener('hidden.bs.modal', event => {
        let target = event.target;
        target.querySelector('.placeholder-glow').style.display = 'block';
    });

    /** MODAL ORDER LIST */
    const modalOrderList = document.getElementById('modalOrderList').addEventListener('show.bs.modal', event => {
        let target = event.target;
        let frames = target.querySelectorAll('[data-cp-frame-content]');
        let route = target.dataset.cpFrameRoute;

        $.ajax({
            url: getUrlRoute(route),
            method: 'POST',
            success: response => {
                const template = target.querySelector('.cp-template').innerHTML;
                const rendered = Mustache.render(template, response);
                target.querySelector('.cp-render').innerHTML = rendered;
                target.querySelector('.placeholder-glow').style.display = 'none';
                $('.cp-render .datetime', target).each(function() {
                    let originalDatetime = $(this).text();
                    let formattedDatetime = convertDatetime(originalDatetime);
                    $(this).text(formattedDatetime);
                });
            },
            error: function(xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    });

    document.getElementById('modalOrderList').addEventListener('hidden.bs.modal', event => {
        let target = event.target;
        target.querySelector('.placeholder-glow').style.display = 'block';
    });


    /** REMOVE ELEMENT TARGET */
    function removeElement(target_elem_id = null) {
        if (!target_elem_id) {
            return false;
        }
        document.querySelector(target_elem_id).remove();
    }

    /** OPEN MODAL */
    function openModal() {

        if (var_alert) {
            let obj = document.getElementById('modalAlert');
            let modalAlert = new bootstrap.Modal(obj, {
                keyboard: false
            });


            obj.addEventListener('show.bs.modal', (event) => {
                let target = event.target;
                let response = {
                    alert: var_alert
                }
                const template = target.querySelector('.cp-template').innerHTML;
                const rendered = Mustache.render(template, response);
                target.querySelector('.cp-render').innerHTML = rendered;
            });

            modalAlert.show();

            obj.addEventListener('hidden.bs.modal', () => {
                if (modalId) {
                    btn_modal = document.getElementById(modalId);
                    if (btn_modal) {
                        btn_modal.click();
                    }
                }
            });
        } else {
            if (modalId) {
                btn_modal = document.getElementById(modalId);
                if (btn_modal) {
                    btn_modal.click();
                }
            }
        }

    }

    /** ALERT */
    const var_alert = <?= !empty($alert) ? json_encode($alert) : 'null' ?>;
    const modalId = <?= !empty($modal) ? json_encode($modal) : 'null' ?>;
    openModal(modalId);

    /** CREDIT CARD FLAG */
    function getCardBrand(cardNumber) {
        let card_number = cardNumber.replace(/[^0-9]/g, '');

        brands = [{
                'pattern': /^402941|^402942/,
                'brand': 'nubank'
            },
            {
                'pattern': /^527600|^527601|^555555/,
                'brand': 'nubank'
            },
            {
                'pattern': /^4[0-9]{12}(?:[0-9]{3})?$/,
                'brand': 'visa'
            },
            {
                'pattern': /^5[1-5][0-9]{14}$/,
                'brand': 'mastercard'
            },
            {
                'pattern': /^3[47][0-9]{13}$/,
                'brand': 'amex'
            },
            {
                'pattern': /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/,
                'brand': 'diners_club'
            },
            {
                'pattern': /^6(?:011|5[0-9]{2})[0-9]{12}$/,
                'brand': 'discover'
            },
            {
                'pattern': /^(?:2131|1800|35\d{3})\d{11}$/,
                'brand': 'jcb'
            },
            {
                'pattern': /^(4011(78|79)|4312(74|75)|4389(35|36)|4514(16|17)|4576(31|32)|4576(35|36)|5041(75|76)|6277(00|01)|6363(68|69)|6504(06|07|08)|6505(31|32|33|34|35)|6507(01|02|03|04|05)|6509(16|17|18|19)|6516(51|52)|6550(00|01|02))\d{10,12}$/,
                'brand': 'elo'
            }
        ];

        for (let item of brands) {
            if (item.pattern.test(card_number)) {

                return item.brand;
            }
        }
        return 'unknown';

        /*
        Nubank: 4029411234567890 | 5276001234567890 | 5555551234567890
        Amex: 378282246310005
        Diners Club: 30569309025904
        Discover: 6011111111111117
        JCB: 3530111333300000
        Elo: 4514161234567890 | 6363681234567890123 | 6507011234567890
        
        */
    }

    /** DATETIME CONVERTER */
    function convertDatetime(mysqlDateTime) {
        // Dividir a data e a hora
        let [date, time] = mysqlDateTime.split(' ');

        // Dividir a data em ano, mês e dia
        let [year, month, day] = date.split('-');

        // Retornar a data no formato dd-mm-yyyy hh:mm:ss
        return `${day}/${month}/${year} ${time}`;
    }
</script>
<?php $this->stop(); ?>