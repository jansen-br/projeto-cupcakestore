<?php

namespace App\Pages\Manager;

use App\AppController;
use App\Components\Product\ProductController;
use App\Components\Product\ProductModel;
use App\Lib\Alert;
use App\Lib\FileManager;
use App\Lib\ImageUploader;
use App\Lib\ImageUploader2;
use App\Lib\Session;
use Exception;

class ManagerController extends AppController
{

    protected $data;
    private $manager = [];

    protected function init(): void
    {

        $this->view->addFolder('manager', __DIR__ . '/tpl');
        $this->manager = Session::get('manager');
        
        if (empty($this->manager)) {
            $this->view->addData([
                'action' => $this->router->route('auth.access'),
                'redirect' => 'manager'
            ]);
            $this->view->print('manager::login');
            exit;
        }
    } 

    public function render(): void
    {
        $this->view->print('manager::index');
    }

    public function renderLogin(): void
    {
        $this->view->print('manager::login');
    }

    public function renderProducts(): void
    {
        $this->view->addData([
            'redirect' => 'manager.products',
            'url_images' => $this->router->route('root') . '/assets/@img/'
        ]);
        $this->view->print('manager::products');
    }

}
