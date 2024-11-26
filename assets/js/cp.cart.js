/** MODAL CART */
const modalCart = document.getElementById('modalCart');
const cpCartBadge = document.getElementById('cpCartBadge');
const tableCart = document.getElementById('tableCart');
const url_cart_show = '<?= $router->route('cart.show') ?>';
const url_cart_remove = '<?= $router->route('cart.remove') ?>';
var cartData = [];
// const cart = '<?= json_encode($cart) ?>';
modalCart.addEventListener('show.bs.modal', event => {
    showItems(url_cart_show);
});

function showItems(url) {
    let html = '';
    tableCart.tBodies[0].innerHTML = '';
    tableCart.querySelector('tfoot td:last-child').innerHTML = '';
    

    $.ajax({
        url: url,
        method: 'POST',
        success: function(response) {
            if (response.products) {
                response.products.forEach((val) => {
                    html += (
                        '<tr>' +
                        '<td class="cart-img"><img class="rounded-circle object-fit-cover" width="48" height="48" src="<?= $router->route('root') ?>/assets/@img/' + val.url_image + '"></td>' +
                        '<td class="cart-info">' +
                        '<div class="h6">' + val.product + '</div>' +
                        '<div class="mb-1">' + val.short + '</div>' +
                        '<div class="mb-1"><span>' + val.quantity + '</span> x <span class="cash-br">' + convertDecimalToCurrencyBR(parseFloat(val.price).toFixed(2)) + '</span></div>' +
                        '<div>' +
                        '<button class="cart-remove btn btn-sm btn-danger" data-cp-cart-item="' + val.id + '"><i class="fa fa-times me-1"></i>Remover</button>' +
                        '</div>' +
                        '</td>' +
                        '<td class="cart-price text-end h6">' + convertDecimalToCurrencyBR(val.total.toFixed(2)) + '</td>' +
                        '</tr>'
                    );
                });

                tableCart.tBodies[0].innerHTML = html;
                tableCart.querySelector('tfoot td:last-child').innerHTML = convertDecimalToCurrencyBR(response.total.toFixed(2));
                cartData = response.products;
                
            }

            document.querySelectorAll('.cart-remove').forEach((button) => {
                button.addEventListener('click', (e) => {
                    removeItem(e.target.dataset.cpCartItem);
                });
            });
        },
        error: function(xhr, status, error) {
            console.error(`Error: ${error}`);
        }
    });
}

function removeItem(id) {
    $.ajax({
        url: url_cart_remove,
        data: {
            id: id
        },
        method: 'POST',
        success: function(response) {
            if (response) {
                showItems(url_cart_show);
                if (response.count > 0) {
                    cpCartBadge.innerText = response.length + '+';
                } else {
                    bootstrap.Modal.getInstance(modalCart).hide();
                    cpCartBadge.remove();
                    document.getElementById('modalCartForm').remove();
                }

                cartData = response.products;

            }
        },
        error: function(xhr, status, error) {
            console.error(`Error: ${error}`);
        }
    });
}