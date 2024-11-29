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
            $('.cp-render .datetime', target).each(function () {
                let originalDatetime = $(this).text();
                let formattedDatetime = convertDatetime(originalDatetime);
                $(this).text(formattedDatetime);
            });
        },
        error: function (xhr, status, error) {
            console.error(`Error: ${error}`);
        }
    });
});

document.getElementById('modalOrderList').addEventListener('hidden.bs.modal', event => {
    let target = event.target;
    target.querySelector('.placeholder-glow').style.display = 'block';
});