<div id="modalConfirm" class="modal fade" tabindex="-1">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Deseja remover este item?</p>
      </div>
      <div class="modal-footer">
        <form action="<?= $action ?>" method="post">
          <input type="hidden" name="redirect" value="<?= (isset($redirect) ? $redirect : '') ?>">
          <input id="modalConfirmId" type="hidden" name="id">
          <input id="modalConfirmMethod" type="hidden" name="_method" value="DELETE">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
          <button type="submit" class="btn btn-primary">Confirmar</button>
        </form>
      </div>
    </div>
  </div>
</div>