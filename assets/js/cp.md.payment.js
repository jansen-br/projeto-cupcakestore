/** MODAL PAYMENT METHOD */
document.getElementById('modalCostumerPaymentMethod').addEventListener('show.bs.modal', event => {
    let btn = event.relatedTarget;
    let target = event.target;
    let route = target.dataset.cpFrameRoute;

    $.ajax({
        url: getUrlRoute(route),
        method: 'POST',
        success: response => {
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

            $('#PaymentMethodNumber').mask('9999999999999999').keyup((el) => {

                let brand = getCardBrand(el.target.value);
                console.log(brand);
                document.getElementById('PaymentMethodFlag').value = brand;
                document.getElementById('PaymentMethodFlagLabel').dataset.cardLogo = brand;

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