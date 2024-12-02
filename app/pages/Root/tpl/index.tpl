<?php

$this->layout('app.layout', ['title' => 'Principal']);


$this->start('header');
$this->insert('root::header');
$this->stop();


// $url = 'http://local.cupcake.com.br/produto/listar?draw=3&columns%5B0%5D%5Bdata%5D=id&columns%5B0%5D%5Bname%5D=&columns%5B0%5D%5Bsearchable%5D=true&columns%5B0%5D%5Borderable%5D=true&columns%5B0%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B0%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B1%5D%5Bdata%5D=product&columns%5B1%5D%5Bname%5D=&columns%5B1%5D%5Bsearchable%5D=true&columns%5B1%5D%5Borderable%5D=true&columns%5B1%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B1%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B2%5D%5Bdata%5D=short&columns%5B2%5D%5Bname%5D=&columns%5B2%5D%5Bsearchable%5D=true&columns%5B2%5D%5Borderable%5D=true&columns%5B2%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B2%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B3%5D%5Bdata%5D=price&columns%5B3%5D%5Bname%5D=&columns%5B3%5D%5Bsearchable%5D=true&columns%5B3%5D%5Borderable%5D=true&columns%5B3%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B3%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B4%5D%5Bdata%5D=&columns%5B4%5D%5Bname%5D=&columns%5B4%5D%5Bsearchable%5D=true&columns%5B4%5D%5Borderable%5D=false&columns%5B4%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B4%5D%5Bsearch%5D%5Bregex%5D=false&order%5B0%5D%5Bcolumn%5D=1&order%5B0%5D%5Bdir%5D=desc&order%5B0%5D%5Bname%5D=&start=0&length=10&search%5Bvalue%5D=t&search%5Bregex%5D=false&_=1733084085167';
// $query_str = parse_url($url, PHP_URL_QUERY);
// parse_str($query_str, $query_array);
// de($query_array);
?>

<?php $this->start('css'); ?>
<style>
    input[name="search"]:focus {
        outline: none;
        box-shadow: none;
    }

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
</style>
<?php $this->stop(); ?>

<?php $this->insert('root::carousel'); ?>

<article class="container">

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
    function convertDecimalToCurrencyBR(entry) {
        entry = entry.toString();
        return entry.replace('.', ',');
    }

    function getUrlRoute(key) {
        const routes = [{
                'root': '<?= $router->route('root') ?>'
            },
            {
                'product.list': '<?= $router->route('product.list') ?>'
            },
            {
                'product.get': '<?= $router->route('product.get') ?>'
            },
            {
                'product.put': '<?= $router->route('product.put') ?>'
            },
            {
                'cart.add': '<?= $router->route('cart.add') ?>'
            },
            {
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
    /** DATALIST */
    let products = new ProductDataList(
        $('#products'), {
            url: getUrlRoute('product.list'),
            folder_image: getUrlRoute('root') + '/assets/@img/',
            order: [
                {column: 0, dir: 'asc'},
                {column: 1, dir: 'Desc'}
            ],
            columns: [{
                    data: 'product'
                },
                {
                    data: 'short'
                },
                {
                    data: 'price'
                }
            ]
        }
    )

    /** REGITER COSTUMER */
    $('.input-email').mask("A", {
        translation: {
            "A": {
                pattern: /[\w@\-.+]/,
                recursive: true
            }
        }
    });

    $('.input-phone').mask("(99) 99999-9999");

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
<script src="<?= $router->route('root') ?>/assets/js/cp.md.product.js"></script>
<script src="<?= $router->route('root') ?>/assets/js/cp.md.order.list.js"></script>
<script src="<?= $router->route('root') ?>/assets/js/cp.md.order.summary.js"></script>
<script src="<?= $router->route('root') ?>/assets/js/cp.md.payment.js"></script>
<?php $this->stop(); ?>