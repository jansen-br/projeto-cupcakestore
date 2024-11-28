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

    [data-cp-frame-content]>*:first-child span {
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

    @keyframes place-holder {
        50% {
            opacity: .2;
        }
    }
</style>
<?php $this->stop(); ?>

<?php $this->insert('root::carousel'); ?>

<article class="container">

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
    const modalCostumerPaymentMethod = document.getElementById('modalCostumerPaymentMethod');
    const url_CostumerPaymentMethod = '<?= $router->route('costumer.render.payment.method') ?>';
    modalCostumerPaymentMethod.addEventListener('show.bs.modal', event => {
        showCostumerPaymentMethod(
            url_CostumerPaymentMethod,
            modalCostumerPaymentMethod
        );
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

    const url_PreferedCreditCard = '<?= $router->route('costumer.set.prefered.creditcard') ?>';

    function eventSetPreferedCreditCard() {
        modalCostumerPaymentMethod.querySelectorAll('input[name="prefered"]').forEach(el => {
            el.addEventListener('change', function() {
                const creditcard_id = this.dataset.cpCreditcardId;
                $.ajax({
                    url: url_PreferedCreditCard,
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


    function eventRemoveItem(elem) {

        const item = document.querySelectorAll(elem);
        item.forEach(el => {
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
                'costumer.remove.creditcard': '<?= $router->route('costumer.remove.creditcard') ?>'
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
        let frames = target.querySelectorAll('[data-cp-frame-content]');
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
                replacePlaceholders(frames, response);
                $('[data-cp-frame-receive] .cash-br').mask('9999,00');
                $('[data-cp-frame-receive] .datetime').each(function() {
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
        removePlaceHolders(target);
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
                replacePlaceholders(frames, response);
                $('[data-cp-frame-receive] .datetime').each(function() {
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
        removePlaceHolders(target);
    });

    /** REPLACE HOLDERS */
    function replacePlaceholders(elements, data) {
        elements.forEach(element => {
            let key = element.dataset.cpFrameContent;
            let data_item = data[key];

            if (Array.isArray(data_item)) {
                data_item.forEach(item => {
                    let first = element.firstElementChild.cloneNode(true);
                    first.dataset.cpFrameReceive = key;
                    replacePlaceholdersTree(first, item);
                    element.appendChild(first);
                });     
            } else {
                let first = element.firstElementChild.cloneNode(true);
                first.dataset.cpFrameReceive = key;
                replacePlaceholdersTree(first, data_item);
                element.appendChild(first);
            }

            element.firstElementChild.style.display = "none";
        });
    }

    function objIsEmpty(obj) {
        for (let prop in obj) {
            return false
        }
        return true;
    }

    function arrayIsEmpty(arr) {
        if (arr.length > 0) {
            return false;
        }
        return true;
    }

    function replacePlaceholdersTree(element, data) {

        element.childNodes.forEach(node => {
            if (node.nodeType === Node.TEXT_NODE) {
                node.textContent = node.textContent.replace(
                    /{:([a-zA-Z0-9_]+)}/g,
                    // (_, key) => data[key] || `{:${key}}`
                    (_, key) => data[key] || ``
                );
            }
        });

        Array.from(element.attributes).forEach(attr => {
            attr.value = attr.value.replace(
                /{:([a-zA-Z0-9_]+)}/g,
                // (_, key) => data[key] || `{:${key}}`
                (_, key) => data[key] || ``
            );
        });

        element.childNodes.forEach(child => {
            if (child.nodeType === Node.ELEMENT_NODE) {
                replacePlaceholdersTree(child, data);
            }
        });
    }

    function removePlaceHolders(target) {
        const elements_receive = target.querySelectorAll('[data-cp-frame-receive]');
        for (let element of elements_receive) {
            element.remove();
        }

        const elements_content = target.querySelectorAll('[data-cp-frame-content]');
        for (let element of elements_content) {
            element.firstElementChild.removeAttribute('style');
        }
    }

    /** REMOVE ELEMENT TARGET */
    function removeElement(target_elem_id = null) {
        if (!target_elem_id) {
            return false;
        }
        document.querySelector(target_elem_id).remove();
    }

    /** OPEN MODAL */
    function openModal(modalId) {
        // if (modalId) {
        //     console.log(modalId);
        //     btn_modal = document.getElementById(modalId);
        //     if (btn_modal) {
        //         btn_modal.click();
        //     }
        // }
        if (var_alert) {
            let obj = document.getElementById('modalAlert');
            let modalAlert = new bootstrap.Modal(obj, {
                keyboard: false
            });


            obj.addEventListener('show.bs.modal', (event) => {
                let target = event.target;
                let alertObj = {
                    alert: var_alert
                }
                replacePlaceholders(target, alertObj);
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
            }
        ];

        for (let item of brands) {
            if (item.pattern.test(card_number)) {
                return item.brand;
            }
        }

        return 'unknown';
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