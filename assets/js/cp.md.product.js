/** MODAL PRODUCT */
document.getElementById('modalProduct').addEventListener('show.bs.modal', event => {
    let btn = event.relatedTarget;
    let target = event.target;
    let route = target.dataset.cpFrameRoute;
    let productsId = btn.dataset.cpId;

    $.ajax({
        url: getUrlRoute('product.get'),
        data: {
            id: productsId
        },
        method: 'POST',
        success: function (response) {
            console.log(response);
            if (response.product.id) {
                response.product.priceFormated = convertDecimalToCurrencyBR(response.product.price);
            }

            const template = target.querySelector('.cp-template').innerHTML;
            const rendered = Mustache.render(template, response);
            target.querySelector('.cp-render').innerHTML = rendered;
            target.querySelector('form').action = getUrlRoute('cart.add');
            target.querySelector('img.image-hight').src = getUrlRoute('root') + '/assets/@img/' + response.product.url_image;
            // target.querySelector('.placeholder-glow').style.display = 'none';

            /** CHANGE PRICE */
            target.querySelector('input[name="quantity"]').addEventListener('change', (e) => {
                let qnt = e.target.value;
                let entry = (qnt * (response.product.price)).toFixed(2);
                target.querySelector('.cash-br').innerHTML = convertDecimalToCurrencyBR(entry);
            });
        },
        error: function (xhr, status, error) {
            console.error(`Error: ${error}`);
        }
    });
});

document.getElementById('modalProduct').addEventListener('hidden.bs.modal', event => {
    // let target = event.target;
    // target.querySelector('.placeholder-glow').style.display = 'block';
});