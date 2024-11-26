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
    protected function init()
    {
        parent::init();
        $this->view->addFolder('order', __DIR__ . '/tpl');
        $this->setModel(new OrderModel);
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

            $cart = new CartController($this->router);
            $order = $cart->calcProducts();

            if (!empty($order)) {
                $order_id = $this->model->registerOrder(
                    $this->costumer['id'],
                    convertCurrencyToDecimal($order['total']),
                    'paid'
                );
                if ($order_id && !empty($order['products'])) {
                    foreach($order['products'] as $v){
                        $item_id = $this->model->registerOrderItems(
                            $v['quantity'],
                            $v['price'],
                            $v['id'],
                            $order_id
                        );
                    }
                }
            }
            
            Alert::set('Pedido realizado!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        Session::remove('cart');
        $this->view->setModal('itemOrderSummary');
        $this->router->redirect('root');
    }
}
