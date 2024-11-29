class ProductDataList {

    constructor(container, args) {
        this.container = container;
        this.args = args;
        this.draw = 0;
        this.recordsTotal = 0;
        this.recordsFiltered = 0;

        this.loadStruct();
        this.loadTools();
        this.#_ajax();
        this.renderStruct();
    }

    #_ajax(vars) {
        let root = this;
        $.ajax({
            url: root.args.url,
            method: 'GET',
            data: vars,
            success: function (response) {
                root.clearData();
                root.loadProducts(response);
            },
            error: function (xhr, status, error) {
                console.error(`Error: ${error}`);
            }
        });
    }

    loadStruct() {
        let root = this;
        let suffix_id = root.generateRandomId();

        root.divTools = document.createElement('div');
        root.divProducts = document.createElement('div');
        root.divPages = document.createElement('div');

        root.divTools.id = "dataListTool_" + suffix_id;
        root.divProducts.id = "dataListProducts_" + suffix_id;
        root.divProducts.setAttribute('class', 'row justify-content-center');
        root.divPages.id = "dataListPages_" + suffix_id;
    }

    loadProducts(response) {
        let root = this;
        if (response.data.length > 0) {
            response.data.forEach((item, index) => {
                root.renderCards(item);
            });
        } else {
            root.renderNoDataFound();
        }
    }

    generateRandomId(length = 6) {
        return Math.random().toString(36).substring(2, length + 2);
    }

    loadTools() {
        let root = this;
        let html = (
            '<div class="my-5">' +
            '<form class="cp-form-search" action="">' +
            '<div class="row justify-content-center">' +
            '<div class="mb-3 col-md-6 col-sm-12">' +
            '<div class="d-flex justify-content-center bg-light rounded-5 p-2">' +
            '<input name="search" type="text" class="w-100 border-0 mx-2" placeholder="">' +
            '<button class="btn"><i class="fa fa-search"></i></button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</form>' +
            '</div>'
        );

        root.divTools.innerHTML = html;

        root.loadSearch();
    }

    loadSearch() {
        let root = this;
        let formSearch = root.divTools.querySelector('form');
        let inputSearch = root.divTools.querySelector('input[name="search"]');
        formSearch.addEventListener('submit', event => {
            event.preventDefault();
            let search_value = inputSearch.value;
            this.#_ajax(root.loadSearchData(search_value));
            console.log();
        })
    }

    loadSearchData(search) {
        let root = this;
        let var_declared = {columns: root.args.columns};
        let var_referenc = {
            "columns":
                [
                    { "data": "", "name": "", "searchable": "true", "orderable": "true", "search": { "value": "", "regex": "false" } }
                ]
        };
        const merged = {
            columns: var_declared.columns.map((col, index) => {
                console.log(col,index);
                return { ...var_referenc.columns[0], ...(col  || {}) };
            })
        };

        merged.search = { "value": search, "regex": "false" };
        console.log(merged);
        return merged;
    }

    clearData() {
        let root = this;
        root.divProducts.innerHTML = "";
    }

    renderNoDataFound() {
        let root = this;
        let html = (
            '<div class="p-5 text-center h3">' +
            'Nenhum produto encontrado!' +
            '</div>'
        );

        $(root.divProducts).html(html);
    }

    renderCards(data) {
        let root = this;

        const col = document.createElement('div');
        const card = document.createElement('div');
        const img = document.createElement('img');
        const title = document.createElement('div');
        const short = document.createElement('div');
        const price = document.createElement('div');
        // const action = document.createElement('div');

        let src = 'data:image/png;base64,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';

        col.className = 'col-auto m-4 p-2 justify-content-center position-relative';

        card.className = 'cp-product-card p-1 rounded bg-light text-center cursor-pointer';

        img.width = '220';
        img.height = '220';
        img.className = 'cp-thumbnail bg-secondary rounded object-fit-cover';

        if (data.url_image) {
            src = root.args.folder_image + data.url_image;
        }

        img.src = src;
        // img.style.backgroundImage = "url('" + root.args.folder_image + data.url_image + "')";
        // img.style.backgroundRepeat = 'none';
        // img.style.backgroundSize = 'cover';

        title.className = 'text-center my-2 h6';
        title.innerHTML = data.product;

        short.className = 'my-1';
        short.innerText = data.short;

        if (data.price) {
            data.price = convertDecimalToCurrencyBR(data.price);
        }

        price.className = 'price my-1';
        price.innerHTML = '<a href="#modalProduct" class="btn btn-primary btn-sm" data-cp-id="' + data.id + '" data-bs-toggle="modal" data-bs-target="#modalProduct"><span class="small me-1">R$</span><span class="h5 ft-bold">' + data.price + '</span></a>';

        col.appendChild(card);
        card.appendChild(img);
        card.appendChild(title);
        card.appendChild(short);
        card.appendChild(price);
        // card.appendChild(action);

        root.divProducts.append(col);
    }

    renderStruct() {
        let root = this;
        root.container.append(root.divTools);
        root.container.append(root.divProducts);
        root.container.append(root.divPages);
    }

}