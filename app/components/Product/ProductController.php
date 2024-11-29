<?php

namespace App\Components\Product;

use App\AppController;
use App\Lib\Alert;
use App\Lib\ImageUploader2;
use Exception;

class ProductController extends AppController
{

    protected $data;
    private const LOCAL_UPLOAD_IMAGE = ASSETS . DS . '@img';

    protected function init()
    {
        $this->setModel(new ProductModel);
    }

    public function get(array $vars)
    {
        
        $this->data = $this->model->setProps($vars)->getProduct();
        $this->data['images'] = $this->model->getProductsImages();

        header('Content-Type: application/json;charset=utf-8');
        echo json_encode(['product' => $this->data]);
    }

    public function list(): void
    {

        $primary_key = 'id';

        $columns = array(
            array('db' => 'id', 'dt' => 'id'),
            array('db' => 'product',  'dt' => 'product'),
            array('db' => 'code',  'dt' => 'code'),
            array('db' => 'short',  'dt' => 'short'),
            array('db' => 'price',  'dt' => 'price'),
            array('db' => 'url_image',  'dt' => 'url_image')
        );

        $this->data = $this->model->listProductsAll($_GET, $primary_key, $columns);
        
        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($this->data);
    }

    public function put($vars): void
    {
        try {

            $image = new ImageUploader2(self::LOCAL_UPLOAD_IMAGE);

            if (empty($vars['id'])) {
                $last_id = $this->model->setProps($vars)->addProduct();
            } else {

                $last_id = $this->model->setProps($vars)->updateProduct();
                /** DELETE IMAGE */
                if (!empty($vars['images_to_delete'])) {
                    foreach ($vars['images_to_delete'] as $image_name) {
                        $image->deleteImage($image_name);
                        $this->model->deleteProductImageByNameId($vars['id'], $image_name);
                    }
                }
            }

            /** IMAGE UPLOAD */
            if (!empty($_FILES['images']) && !empty($last_id)) {


                $totalFiles = count($_FILES['images']);

                for ($i = 0; $i < $totalFiles; $i++) {
                    if (empty($_FILES['images']['name'][$i])) {
                        continue;
                    }
                    $image_name = $_FILES['images']['name'][$i];
                    $image_tmp_name = $_FILES['images']['tmp_name'][$i];
                    $target_path = $image->uploadImage($image_name, $image_tmp_name, $last_id);
                    /** PUT DATA */
                    $product_images_id[] = $this->model->addProductImage($last_id, $target_path);
                }
            }



            Alert::set('Produto cadastrado com sucesso!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->router->redirect((!empty($vars['redirect']) ? $vars['redirect'] : ''));
    }


    public function update($vars): void
    {
        try {
            $product = new ProductModel();
            $this->model->setProps($vars)->updateProduct();
            Alert::set('Alterações realizadas com sucesso!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->router->redirect((!empty($vars['redirect']) ? $vars['redirect'] : ''));
    }

    public function delete(array $vars): void
    {
        try {
            $product = new ProductModel();
            $image = new ImageUploader2(self::LOCAL_UPLOAD_IMAGE);

            $id = !empty($vars['id']) ? $vars['id'] : 0;
            $this->data['images'] = $this->model->setProps($vars)->getProductsImages();

            $maped = array_map(function ($n) {
                return $n['url_image'];
            }, $this->data['images']);

            if (!empty($maped)) {
                foreach ($maped as $image_name) {
                    $image->deleteImage($image_name);
                    $this->model->deleteProductImageByNameId($id, $image_name);
                }
                $this->model->deleteProduct($id);
            }

            // $this->model->deleteProductImageAll($id);

            Alert::set('Produto removido com sucesso!', 'success');
        } catch (Exception $e) {
            Alert::set($e->getMessage(), 'warning');
        }

        $this->router->redirect((!empty($vars['redirect']) ? $vars['redirect'] : ''));
    }
}
