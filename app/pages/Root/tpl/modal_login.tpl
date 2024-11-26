<!-- Modal Login -->
<div class="modal fade" id="modalLogin" tabindex="-1" aria-labelledby="modalLoginLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="text-end px-2 pt-2">
                <button type="button" class="btn btn-light rounded-circle me-1 mt-1" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></button>
            </div>
            <div class="modal-body position-relative">
                <!-- Pills navs -->
                <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" id="tab-login" href="#pills-login" role="tab"
                            aria-controls="pills-login" aria-selected="true" data-bs-toggle="tab" data-bs-target="#pills-login">Entrar</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="tab-register" href="#pills-register" role="tab"
                            aria-controls="pills-register" aria-selected="false" data-bs-toggle="tab" data-bs-target="#pills-register">Registrar-se</a>
                    </li>
                </ul>
                <!-- Pills navs -->

                <!-- Pills content -->
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                        <form action="<?= $router->route('costumer.access') ?>" method="post">
                            <div class="form-floating mb-3">
                                <input name="email" type="email" class="form-control input-email" id="floatingInput" placeholder="name@example.com" required>
                                <label for="floatingInput">E-mail de acesso</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input name="account_password" type="password" class="form-control" id="floatingPassword" placeholder="Senha" required>
                                <label for="floatingPassword">Senha</label>
                            </div>
                            <!-- Submit button -->
                            <div class="d-grid gap-2">
                                <input type="hidden" name="redirect" value="<?= (isset($redirect) ? $redirect : '') ?>">
                                <button type="submit" class="btn btn-primary btn-block mb-4">Entrar</button>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                        <form action="<?= $router->route('costumer.registre') ?>" method="post">
                            <div class="form-floating mb-3">
                                <input name="first_name" type="text" class="form-control" id="FirstName" placeholder="Nome" required>
                                <label for="FirstName">Nome</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input name="last_name" type="text" class="form-control" id="LastName" placeholder="Sobrenome" required>
                                <label for="LastName">Sobrenome</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input name="phone" type="text" class="form-control input-phone" id="Phone" placeholder="(99) 99999-9999" required>
                                <label for="Phone">Celular</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input name="email" type="email" class="form-control input-email" id="Email" placeholder="(99) 99999-9999" required>
                                <label for="Email">E-mail</label>
                            </div>

                            <hr>
                            <div class="form-floating mb-3">
                                <input name="account_password" type="password" class="form-control" id="AccountPassword" placeholder="(99) 99999-9999" required>
                                <label for="AccountPassword">Senha</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input name="confirm_account_password" type="password" class="form-control" id="ConfirmAccountPassword" placeholder="(99) 99999-9999" required>
                                <label for="ConfirmAccountPassword">Confirmar Senha</label>
                            </div>
                            <!-- Checkbox -->
                            <div class="form-check d-flex justify-content-center mb-4">
                                <input class="form-check-input me-2" type="checkbox" value="" id="registerCheck" checked
                                    aria-describedby="registerCheckHelpText" />
                                <label class="form-check-label" for="registerCheck">
                                    Li e aceito os termos do site
                                </label>
                            </div>
                            <!-- Submit button -->
                            <div class="d-grid gap-2">
                                <input type="hidden" name="redirect" value="<?= (isset($redirect) ? $redirect : '') ?>">
                                <input type="hidden" name="_method" value="PUT">
                                <button type="submit" class="btn btn-primary btn-block mb-4">Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- Pills content -->
            </div>
        </div>
    </div>
</div>