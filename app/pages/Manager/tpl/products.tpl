<?php

$this->layout('adm.layout', ['title' => 'Principal']);

?>

<div id="cpButtons" class="mb-3">
    <a href="javascript:void(0);" id="cpBtnAdd" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalProduct">
        <i class="fa fa-plus"></i>
    </a>
</div>
<div class="table-responsive-md">
    <table id="productsTable" class="table table-hover responsive nowrap" style="width:100%"></table>
</div>

<?php $this->insert('manager::modal-product', [
    'action' => $router->route('product.put')
]); ?>

<?php $this->insert('modal-confirm', [
    'action' => $router->route('product.delete')
]); ?>


<?php $this->start('css'); ?>
<style>

</style>
<?php $this->stop(); ?>

<?php $this->start('js'); ?>
<script src="<?= $router->route('root') ?>/assets/js/image.preview.js"></script>
<script>
    $(document).ready(function() {
        const inputProduct = document.getElementById('mdProduct');
        const inputCode = document.getElementById('mdCode');


        inputProduct.addEventListener('blur', () => {
            const value = inputProduct.value;
            const processedValue = value
                .replace(/[^a-zA-Z0-9\s\._\-]/g, '')
                .replace(/\s+/g, '-');
            if (!inputCode.value) {
                inputCode.value = processedValue.toLowerCase();
            }
        });

        inputCode.addEventListener('input', (event) => {
            const regex = /^[a-zA-Z0-9\-\._]*$/;
            const value = inputCode.value;
            if (!regex.test(value)) {
                inputCode.value = value.replace(/[^a-zA-Z0-9\-\._]/g, '');
            }
        });



        /** TABLE */

        let url_manager_list_products = "<?= $router->route('product.list') ?>";

        let table = new DataTable("#productsTable", {
            language: {
                url: '<?= $router->route('root') ?>/assets/json/dataTables.pt-BR.json'
            },
            responsive: true,
            processing: true,
            serverSide: true,
            pageLength: 10,
            ajax: url_manager_list_products,
            order: [
                [1, 'desc']
            ],
            columns: [{
                    title: '#',
                    data: 'id',
                    width: '100px'
                },
                {
                    title: 'Produto',
                    data: 'product'
                },
                {
                    title: 'Resumo',
                    data: 'short'
                },
                {
                    title: 'Preço',
                    data: 'price',
                    width: '100px',
                    render: ['number', '.', ',', 2, 'R$ ']
                },
                {
                    data: null,
                    className: 'text-end',
                    width: '100px',
                    orderable: false,
                    render: function(data, type, row) {
                        let id = row.id;
                        return (
                            '<a href="javascript:void(0)" data-cp-id="' + id + '" class="btn btn-sm" data-bs-toggle="modal" data-bs-target="#modalProduct"><i class="fa fa-edit"></i></a>' +
                            '<a href="javascript:void(0)" data-cp-id="' + id + '" class="btn btn-sm" data-bs-toggle="modal" data-bs-target="#modalConfirm"><i class="fa fa-trash"></i></a>'
                        );
                    }
                }

            ]
        });

        /** MASK */
        $('#mdPrice').mask("#.##0,00", {
            reverse: true
        });
        /** RITCHTEXT */
        $('#mdDescription').richText({
            bold: true,
            italic: true,
            underline: true,

            leftAlign: true,
            centerAlign: true,
            rightAlign: true,
            justify: true,

            ol: true,
            ul: true,
            fontColor: false,
            fontSize: false,
            urls: false,
            imageUpload: false,
            fileUpload: false,
            table: false,
            fonts: false,
            backgroundColor: false,
            videoEmbed: false,
            code: true,
            heading: false,
            translations: richtext_translations
        });
        /** MODAL PRODUCT */
        const modalProduct = document.getElementById('modalProduct');
        const url_images = '<?= $url_images ?>';
        if (modalProduct) {
            modalProduct.addEventListener('show.bs.modal', event => {
                const button = event.relatedTarget;
                const modalProductForm = document.getElementById('modalProductForm');
                const modalProductSubmitTrigger = document.getElementById('modalProductSubmitTrigger');
                const mdProduct = document.getElementById('mdProduct');
                const mdCode = document.getElementById('mdCode');
                const mdShort = document.getElementById('mdShort');
                const mdDescription = document.getElementById('mdDescription');
                const mdPrice = document.getElementById('mdPrice');
                const mdId = document.getElementById('mdId');

                mdProduct.value = "";
                mdCode.value = "";
                // mdCode.disabled = false;
                mdShort.value = "";
                mdDescription.previousSibling.innerHTML = "";
                mdDescription.value = "";
                mdPrice.value = "";
                mdId.value = "";
                document.getElementById('ContainerPreview').innerHTML = "";

                let previewImages = new ImagePreview(
                    document.getElementById('mdImages'),
                    document.getElementById('ContainerPreview')
                );

                if (button.dataset.cpId) {
                    $.ajax({
                        url: '<?= $router->route('product.get') ?>',
                        dataType: "json",
                        data: {
                            'id': button.dataset.cpId
                        },
                        method: "POST",
                        timeout: 20000,
                        beforeSend: function() {
                            modalProductForm.style.display = 'none';
                            modalProductSpinner.classList.toggle("d-none");
                        },
                        error: function(xhr, status) {
                            console.log('Sender: ' + status);
                        }
                    }).done(function(data) {
                        if (data) {
                            if (data.product.id) {
                                data = data.product;

                                modalProductForm.style.display = 'block';
                                modalProductSpinner.classList.toggle("d-none");
                                // mdCode.disabled = true;

                                mdProduct.value = data.product;
                                mdCode.value = data.code;
                                mdShort.value = data.short;
                                mdDescription.previousSibling.innerHTML = data.description;
                                mdDescription.value = data.description;
                                mdPrice.value = convertDecimalToCurrency(data.price);
                                mdId.value = data.id;

                                previewImages.createThumbnails(data.images, url_images);
                            }
                        }
                    });
                }



            })
        }

        // modalProductForm.addEventListener('submit', (e) => {
        //     e.preventDefault();
        // });

        /** MODAL CONFIRM */
        const modalConfirm = document.getElementById('modalConfirm')
        if (modalConfirm) {
            modalConfirm.addEventListener('show.bs.modal', event => {
                const button = event.relatedTarget;
                const modalConfirmId = document.getElementById('modalConfirmId');
                const row = $(button).parents('tr');
                let data = table.row(row).data();

                modalConfirmId.value = data.id ? data.id : 0;
            })
        }

    });
</script>
<?php $this->stop(); ?>