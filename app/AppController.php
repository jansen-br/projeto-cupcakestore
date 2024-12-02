<?php

namespace App;

use App\Lib\Session;
use CoffeeCode\Router\Router;

class AppController
{

    protected Router $router;
    protected AppView $view;
    protected object $model;
    protected $session;
    
    public function __construct(Router $router)
    {
        Session::start();
        $this->setRouter($router);
        $this->setView(new AppView(THEMES, 'tpl'));
        $this->view->addData(['router' => $this->router]);
        $this->init();
    }

    protected function setView(AppView $view): void
    {
        $this->view = $view;
    }

    protected function setModel(object $model) {
        $this->model = $model;
    }

    public function setRouter(Router $router): void
    {
        $this->router = $router;
    }

    protected function init() {}

}
