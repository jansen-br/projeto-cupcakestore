<!-- Modal Product -->
<div class="modal fade" id="modalProduct" tabindex="-1" aria-labelledby="modalProductLabel">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalProductLabel">Dados do Produto</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="text-center">
                    <div id="modalProductSpinner" class="spinner-border d-none" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <form id="modalProductForm" class="needs-validation" action="<?= $action ?>" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="mdProduct" class="form-label">Produto</label>
                            <input
                                type="text"
                                class="form-control"
                                name="product"
                                id="mdProduct"
                                aria-describedby="helpId"
                                placeholder="Nome do produto"
                                required />
                        </div>
                        <div class="col-md-12 mb-3">
                            <label for="mdCode" class="form-label required">Código</label>
                            <input
                                type="text"
                                class="form-control"
                                name="code"
                                id="mdCode"
                                placeholder="Código do produto" required />
                        </div>
                        <div class="col-md-12 mb-3">
                            <label for="mdShort" class="form-label">Breve descrição</label>
                            <input
                                type="text"
                                class="form-control"
                                name="short"
                                id="mdShort"
                                maxlength="250"
                                placeholder="Breve descrição do produto" />
                        </div>
                        <div class="col-md-12 mb-3">
                            <label for="mdDescription" class="form-label">Descrição</label>
                            <textarea class="form-control" name="description" id="mdDescription" rows="3"></textarea>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="mdPrice" class="form-label">Preço</label>
                            <input
                                type="text"
                                class="form-control"
                                name="price"
                                id="mdPrice"
                                aria-describedby="helpId"
                                placeholder="0,00" />
                        </div>
                    </div>
                    <hr>

                    <div>
                        <label for="mdImages" class="btn btn-primary"><i class="fa fa-plus-circle"></i> Adicionar imagens</label>
                        <input class="d-none" type="file" id="mdImages" multiple accept="image/*">
                        <div id="ContainerPreview" class="row"></div>
                    </div>

                    <input type="hidden" name="redirect" value="<?= (isset($redirect) ? $redirect : '') ?>">
                    <input id="mdId" type="hidden" name="id">
                    <input type="hidden" name="_method" value="PUT">
                    <button id="modalProductSubmit" type="submit" class="d-none">Salvar</button>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                <button id="modalProductSubmitTrigger" type="button" class="btn btn-primary" onclick="document.getElementById('modalProductSubmit').click();">Salvar</button>
            </div>
        </div>
    </div>
</div>