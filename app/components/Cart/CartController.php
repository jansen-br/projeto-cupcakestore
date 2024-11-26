<?php

namespace App\Components\Cart;

use App\AppController;
use App\Components\Product\ProductModel;
use App\Lib\Session;
use DateTime;

class CartController extends AppController
{

    protected array $cart;
    protected array $data;

    protected function init()
    {
        $this->view->addFolder('cart', __DIR__ . '/tpl');
        $this->setModel(new CartModel);
        $session = Session::get('cart');
        $this->cart = !empty($session) ? $session : [];
    }

    public function add($vars): void
    {

        $id = ($vars['id']) ? $vars['id'] : 0;
        $quantity = ($vars['quantity']) ? $vars['quantity'] : 0;
        $date = new DateTime('now');
        $datetime = $date->format('Y-m-d H:i:s');
        $push = true;

        if ($id && $quantity) {
            if (!empty($this->cart)) {
                foreach ($this->cart as $k => $cart) {
                    if (!empty($cart['id']) && $cart['id'] == $id) {
                        $qt = $this->cart[$k]['quantity'];
                        $this->cart[$k]['quantity'] = $qt + $quantity;
                        $this->cart[$k]['datetime'] = $datetime;
                        $push = false;
                    }
                }
            }

            if ($push) {
                $this->cart[] = [
                    'id' => $id,
                    'quantity' => (int)($quantity),
                    'datetime' => $datetime
                ];
            }

            Session::set('cart', $this->cart);
        }

        $this->router->redirect((!empty($vars['redirect']) ? $vars['redirect'] : ''));
    }


    public function show()
    {
        $cart = $this->cart;
        $product = new ProductModel;
        $return = [];
        $total = 0;
        if (!empty($cart)) {
            foreach ($cart as $vars) {
                $id = $vars['id'];
                $quantity = (int)($vars['quantity']);

                $data = $product->setProps(['id' => $id])->getProduct();

                $array = [
                    'product' => $data['product'],
                    'price' => floatval($data['price']),
                    'short' => $data['short'],
                    'url_image' => $data['url_image'],
                    'datetime' => $vars['datetime'],
                    'total' => round(floatval($data['price']) * $quantity, 2),
                ];
                $total += $array['total'];
                $return['products'][] =  $vars + $array;
            }

            $return['total'] = $total;
        }

        // header('Content-Type: application/json;charset=utf-8');
        // echo json_encode($return);
        $this->view->print('cart::table', ['data' => $return, 'costumer' => Session::get('costumer')]);
    }

    public function calcProducts(): array
    {
        $cart = $this->cart;
        $product = new ProductModel;
        $return = [];
        $total = 0;
        if (!empty($cart)) {
            foreach ($cart as $vars) {
                $id = $vars['id'];
                $quantity = (int)($vars['quantity']);

                $data = $product->setProps(['id' => $id])->getProduct();

                $array = [
                    'product' => $data['product'],
                    'price' => floatval($data['price']),
                    'short' => $data['short'],
                    'url_image' => $data['url_image'],
                    'datetime' => $vars['datetime'],
                    'total' => round(floatval($data['price']) * $quantity, 2),
                ];
                $total += $array['total'];
                $return['products'][] =  $vars + $array;
            }

            $return['total'] = $total;

            return $return;
        }

        return [];
    }

    public function remove($vars)
    {
        $id = ($vars['id']) ? $vars['id'] : 0;
        $data = $this->cart;
        $removed = false;
        if (!empty($data)) {
            foreach ($data as $k => $cart) {
                if (!empty($cart['id']) && $cart['id'] == $id) {
                    unset($data[$k]);
                    $removed = true;
                }
            }
            $data = array_values($data);
        }

        if ($removed) {
            $this->cart = $data;
            Session::set('cart', $this->cart);
        }

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode([
            'removed' => true,
            'count' => count($this->cart),
            'products' => $this->cart
        ]);
    }
}
