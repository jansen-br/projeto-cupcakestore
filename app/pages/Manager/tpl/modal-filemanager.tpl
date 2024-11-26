<!-- Modal Product -->
<div class="modal fade" id="modalFileManager" tabindex="-1" aria-labelledby="modalFileManagerLabel">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalFileManagerLabel">Gerenciador de Arquivos</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <div id="modalFileManagerSpinner" class="spinner-border d-none" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <form class="mb-2" id="imageUploadForm" enctype="multipart/form-data" method="post">
                    <div class="input-group mb-3">
                        <input type="file" name="image" class="form-control" id="imageUploadInput">
                        <button class="btn btn-primary" id="imageUploadSubmit" type="submit">Enviar</button>
                    </div>
                </form>
                <div id="message"></div>
                <div class="table-reponsive">
                    <table id="modalFileManagerTable" class="table table-sm w-100">
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>