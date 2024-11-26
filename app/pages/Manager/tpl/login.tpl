<?php

$this->layout('adm.layout.login', ['title' => 'Principal']);

?>
<div class="container position-absolute">
    <div class="row d-flex justify-content-center">
        <form action="<?= isset($action) ? $action : '' ?>" class="col-xl-4 bg-light rounded-3 p-0" method="post">
            <div class="rounded-top-3 p-2 text-center">
                <h3>Gerência</h3>
            </div>
            <div class="p-2">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="UserName" name="username" placeholder="Usuário">
                    <label for="UserName">Nome de Usuário</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="PassWord" name="account_password" placeholder="Senha">
                    <label for="PassWord">Senha</label>
                </div>
                <!-- Submit button -->
                <div class="d-grid gap-2">
                    <input type="hidden" name="redirect" value="<?= isset($redirect) ? $redirect : '' ?>">
                    <button class="btn btn-primary" type="submit">Entrar</button>
                </div>
            </div>
        </form>
    </div>
</div>