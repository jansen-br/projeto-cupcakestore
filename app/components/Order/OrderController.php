<?php

namespace App\Components\Order;

use App\AppController;
use App\Components\Cart\CartController;
use App\Components\Costumer\CostumerController;
use App\Components\Costumer\CostumerModel;
use App\Lib\Alert;
use App\Lib\Session;
use Exception;

class OrderController extends CostumerController
{

    protected $cart;
    protected $costumer;

    protected function init()
    {
        parent::init();
        $this->view->addFolder('order', __DIR__ . '/tpl');
        $this->setModel(new OrderModel);
        $this->costumer = Session::get('costumer');
    }

    public function renderPreOrder()
    {
        $cart = new CartController($this->router);
        $model_costumer = new CostumerModel;

        if (!empty($this->costumer['id'])) {
            $data_address = $model_costumer->getPreferedAddress($this->costumer['id']);
        }

        if (!empty($this->costumer['id'])) {
            $creditcard = $model_costumer->getPreferedCreditCard($this->costumer['id']);
        }

        $this->view->print('order::preorder', [
            'costumer' => $this->costumer,
            'address' => $data_address,
            'creditcard' => $creditcard,
            'cart' =>  $cart->calcProducts()
        ]);
    }

    public function finalizeOrder($vars)
    {
        try {
            if(!$this->costumer['id']){
                throw new Exception('Cliente não cadastrado');
            }

            $cart = new CartController($this->router);
            $costumer_model = new CostumerModel();

            $order = $cart->calcProducts();
            $costumer_payment = $costumer_model->getPreferedCreditCard($this->costumer['id']);
            $costumer_address = $costumer_model->getPreferedAddress($this->costumer['id']);

            if(empty($costumer_payment)){
                $this->view->setModal('itemCostumerPaymentMethod');
                throw new Exception('Método de pagamento não cadastrado!');
            }

            if(empty($costumer_address)){
                $this->view->setModal('itemCostumerAddress');
                throw new Exception('Endereço de entrega não cadastrado!');
            }

            if (!empty($order)) {
                $order_id = $this->model->registerOrder(
                    $this->costumer['id'],
                    convertCurrencyToDecimal($order['total']),
                    'paid',
                    json_encode($costumer_address),
                    json_encode($costumer_payment)
                );
                if ($order_id && !empty($order['products'])) {
                    foreach ($order['products'] as $v) {
                        $item_id = $this->model->registerOrderItems(
                            $v['id'],
                            $order_id,
                            $v['quantity'],
                            $v['price'],
                            $v['total']
                        );
                    }
                }
            }else{
                throw new Exception('Pedido não foi definido!');
            }
            
            Session::remove('cart');
            $this->view->setModal('itemListOrders');
            Alert::set('Pedido realizado!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }
        
        $this->router->redirect('root');
    }

    public function renderOrderSummary($vars)
    {


        if (!empty($vars['order_id'])) {
            $order_summary['order'] = ($this->model->getOrder($vars['order_id'], $this->costumer['id']));
        } else {
            $order_summary['order'] = ($this->model->getLastOrder($this->costumer['id']));
        }
        
        if (!empty($order_summary['order']['id'])) {
            $order_summary['order']['number'] = str_pad($order_summary['order']['id'], 5, '0', STR_PAD_LEFT);
            $order_summary['order_items'] = $this->model->getOrderItems($order_summary['order']['id']);
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($order_summary);
    }

    public function listOrders()
    {
        $arr = [];
        // $this->costumer['id'] = 8;
        if (!empty($this->costumer['id'])) {
            $orders = $this->model->listOrders($this->costumer['id']);

            $arr['order_list'] = array_map(function ($item) {
                $item['number'] = $this->defNumberOrder($item['id']);
                return $item;
            }, $orders);
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($arr);
    }

    private function defNumberOrder(int $str)
    {
        return str_pad($str, 5, '0', STR_PAD_LEFT);
    }
}
