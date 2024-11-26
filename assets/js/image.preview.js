class ImagePreview {
    constructor(input, container, args = {}) {

        try {
            if (!input && !container && !is_object(args)) {
                throw "myException";
            }

            this.input = input;
            this.div_preview = container;
            this.args = args;


            this.#init();
            this.#onChange();

        } catch (error) {
            this.#logErrors(error);
        }

    }

    #logErrors(error = "") {
        console.error(error);
    }

    #init() {
        this.args.maxImages = 3;
        this.input.value = "";
    }

    #onChange() {

        try {
            let root = this;
            let input = root.input;
            let div_preview = root.div_preview;
            let images_max = root.args.maxImages;

            input.addEventListener('change', function (event) {
                const files = event.target.files;
                console.log(files);
                for (const file of files) {
                    const preview_images = div_preview.querySelectorAll('img');

                    if (preview_images.length < images_max) {
                        root.url_image = URL.createObjectURL(file);
                        root.#createImageThumbnail().#createInputFile(file).mountThumbnail();
                    }
                }

                input.value = "";
                root.#orderInputRadio();
            });

            
        } catch (error) {
            this.#logErrors(error);
        }
    }

    #createImageThumbnail(image_name) {
        try {

            let root = this;

            const divCol = document.createElement('div');
            const divCard = document.createElement('div');
            const divCardBody = document.createElement('div');
            const img = document.createElement('img');
            const button = document.createElement('button');
            const label = document.createElement('label');


            divCol.className = 'col-auto mt-3';
            divCol.id = 'ImageCard' + root.#setID();
            divCard.className = 'card';
            divCardBody.className = 'card-body text-center';

            img.width = "160";
            img.height = "160";
            img.className = 'rounded-top object-fit-cover';
            img.src = root.url_image;

            button.setAttribute("type", "button");
            button.className = 'btn btn-sm btn-danger';
            button.innerHTML = '<i class="fa fa-times"></i>';
            button.onclick = function () {
                root.deleteImageThumbnail(divCol.id, image_name);
            };

            label.className = 'btn btn-sm btn-light';
            label.innerHTML = '<input type="radio" name="card" class="form-check-input">';
            label.name = 'imgthumbnail';



            root.elem_col = divCol;
            root.elem_card = divCard;
            root.elem_card_body = divCardBody;
            root.elem_label = label;
            root.elem_image = img;
            root.elem_button = button;

            return root;
            // div_preview.appendChild(divCol);
        } catch (e) {
            this.#logErrors(e);
        }
    }

    #createInputFile(file) {

        let root = this;
        let inputImage = document.createElement('input');

        inputImage.setAttribute('type', 'file');
        inputImage.style.display = 'none';
        inputImage.name = 'images[]';
        inputImage.files = root.#duplicateFile(file);

        this.elem_card_body.appendChild(inputImage);

        return root;
    }

    mountThumbnail() {
        let root = this;

        root.elem_card_body.appendChild(root.elem_button);
        root.elem_card_body.appendChild(root.elem_label);

        root.elem_card.appendChild(root.elem_image);
        root.elem_card.appendChild(root.elem_card_body);

        root.elem_col.appendChild(root.elem_card);

        root.div_preview.appendChild(root.elem_col);
    }

    createThumbnails(data = [], url_path) {
        let root = this;
        let html = "";
        if (data.length > 0) {
            data.forEach((val, i) => {
                root.url_image = url_path + val.url_image;
                root.#createImageThumbnail(val.url_image).mountThumbnail();
            });
        }
        root.#orderInputRadio();
    }

    #createInputDataDelete(image_name) {
        let root = this;
        if (image_name) {
            const input = document.createElement('input');
            input.setAttribute('type', 'hidden');
            input.name = 'images_to_delete[]';
            input.value = image_name;
            root.div_preview.appendChild(input);
        }
    }

    #setID() {
        let new_id = "_" + Math.random().toString(16).slice(2)
        return new_id;
    }

    deleteImageThumbnail(elemId, images_id) {
        document.getElementById(elemId).remove();
        this.#createInputDataDelete(images_id);
        this.#orderInputRadio();
    }

    #duplicateFile(file) {
        let dt = new DataTransfer();
        let f = file;
        dt.items.add(
            new File(
                [f.slice(0, f.size, f.type)],
                f.name
            ));
        return dt.files;
    }

    #orderInputRadio() {
        let root;
        const radios = document.querySelectorAll('input[name="card"]');

        // Verifica se algum radio está marcado
        let isChecked = false;
        radios.forEach((radio, i) => {
            radio.value = i;
            if (radio.checked) {
                isChecked = true;
            }
        });

        // Se nenhum radio estiver marcado, marca o primeiro
        if (!isChecked && radios.length > 0) {
            radios[0].checked = true;
        }

    }

}