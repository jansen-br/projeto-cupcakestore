<?php

namespace App\Components\Auth;

use App\AppController;
use App\Lib\Alert;
use App\Lib\Session;
use Exception;

class AuthController extends AppController
{

    protected function init(): void
    {
        $this->setModel(new AuthModel);
    }

    public function access($vars)
    {
        try {
            if (empty($vars['username']) && empty($vars['password'])) {
                throw new Exception('Por favor, preencher os campos do formulário!');
            }

            $data = $this->model->setProps($vars)->login();

            if (empty($data)) {
                throw new Exception('Usuário e senha inválidos!');
            }

            Session::set('manager', $data);
            Alert::set('Acesso permitido!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->router->redirect((!empty($vars['redirect']) ? $vars['redirect'] : ''));
    }

    public function leave()
    {
        if (Session::remove('manager')) {
            Alert::set('Saiu da conta!', 'success');
        }
        $this->router->redirect((!empty($_REQUEST['redirect']) ? $_REQUEST['redirect'] : ''));
    }
}
