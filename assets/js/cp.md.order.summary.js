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