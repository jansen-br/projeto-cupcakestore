<?php

namespace App\Pages\Root;

use App\AppController;
use App\Lib\Alert;
use App\Lib\Session;

class RootController extends AppController
{

    protected $data;

    protected function init()
    {
        $this->view->addFolder('root', __DIR__ . '/tpl');
    }

    public function render()
    {
        $costumer = Session::get('costumer');
        $cart = Session::get('cart');
        $this->view->addData([
            'costumer' => $costumer,
            'redirect' => 'root',
            'cart' => $cart
        ]);
        $this->view->print('root::index');
    }
}
