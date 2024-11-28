<?php

namespace App\Components\Costumer;

use App\AppController;
use App\Lib\Alert;
use App\Lib\Session;
use Exception;
use stdClass;

class CostumerController extends AppController
{
    protected $data;
    protected $costumer;
    protected $alert;

    protected function init()
    {
        $this->view->addFolder('costumer', __DIR__ . '/tpl');
        $this->setModel(new CostumerModel);
        $this->costumer = Session::get('costumer');
    }

    private function setCostumerObjs() {}

    public function access($vars)
    {
        try {

            if (empty($vars['email']) && empty($vars['account_password'])) {
                throw new Exception('Por favor, preencher os campos do formulário!');
            }

            $data = $this->model->setProps($vars)->login();

            if (empty($data)) {
                throw new Exception('Usuário e senha inválidos!');
            }

            Session::set('costumer', $data);
            Alert::set('Acesso permitido!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->router->redirect(
            (!empty($vars['redirect']) ? $vars['redirect'] : ''),
            ['modal' => 'cpUserBtn']
        );
    }

    public function registre($vars)
    {
        try {
            if ($vars['account_password'] !== $vars['confirm_account_password']) {
                throw new Exception('Senhas não conferem!');
            }

            $data = $this->model->setProps($vars)->registre();
            if (!empty($data)) {
                Session::set('costumer', $data);
            } else {
                throw new Exception('Não foi possível criar conta do cliente!');
            }

            Alert::set('Conta registrada com sucesso!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->router->redirect((!empty($vars['redirect']) ? $vars['redirect'] : ''), ['modal' => 'cpUserBtn']);
    }

    public function leave()
    {
        if (Session::remove('costumer')) {
            Alert::set('Saiu da conta!', 'success');
        }
        $this->router->redirect('root');
    }

    public function renderPaymentMethod()
    {

        $array = [];

        if (!empty($this->costumer['id'])) {
            $array['creditcard'] = $this->model->getCreditCards($this->costumer['id']);
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($array);
    }

    public function renderAddressDelivery()
    {

        $addresses = !empty($this->costumer) ? $this->model->setProps($this->costumer)->getAddresses() : [];

        $this->view->print('costumer::address_delivery', [
            'costumer' => $this->costumer,
            'addresses' => $addresses,
            'redirect' => 'root'
        ]);
    }

    public function registreAddressDelivery($vars)
    {
        try {

            if (!empty($this->costumer)) {
                $address = $this->model->registreAddress(
                    $this->costumer['id'],
                    $vars['postal_code'],
                    $vars['address'],
                    $vars['neighborhood'],
                    $vars['city'],
                    $vars['state']
                );
            }
            Alert::set('Endereço registrado!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->view->setModal('itemCostumerAddress');
        $this->router->redirect('root');
    }

    public function setPreferedAddress($vars)
    {

        try {
            if ($this->model->setPreferedAddress($this->costumer['id'], $vars['address_id'])) {
                $m = true;
            }
        } catch (Exception $e) {
            $m = $e->getMessage();
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($m);
    }

    public function removeAddress($vars)
    {
        try {
            if ($this->model->removeAddress($vars['address_id'])) {
                $return = [
                    'return' => true,
                    'message' => 'Endereço removido!'
                ];
            }
        } catch (Exception $e) {
            $return = [
                'return' => false,
                'message' => $e->getMessage()
            ];
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($return);
    }

    public function registreCreditCard($vars)
    {
        try {
            if (!empty($this->costumer)) {
                $address = $this->model->registreCreditCard(
                    $this->costumer['id'],
                    $vars['number'],
                    $vars['flag']
                );
                Alert::set('Cartão registrado!', 'success');
            }
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->view->setModal('itemCostumerPaymentMethod');
        $this->router->redirect('root');
    }

    public function setPreferedCreditCard($vars)
    {
        $m = false;
        try {
            if ($this->model->setPreferedCreditCard($this->costumer['id'], $vars['creditcard_id'])) {
                $m = true;
            }
        } catch (Exception $e) {
            $m = $e->getMessage();
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($m);
    }

    public function removeCreditCard($vars)
    {
        try {
            if ($this->model->removeCreditCard($vars['id'])) {
                $return = [
                    'return' => true,
                    'message' => 'Item removido!'
                ];
            }
        } catch (Exception $e) {
            $return = [
                'return' => false,
                'message' => $e->getMessage()
            ];
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($return);
    }
}
