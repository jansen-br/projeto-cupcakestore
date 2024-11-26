<?php

namespace App\Components\Product;

use App\AppModel;
use App\Lib\SSP as LibSSP;
use Exception;

class ProductModel extends AppModel
{

    const PRODUCTS = 'products';
    const PRODUCTS_IMAGES = 'products_images';
    const VIEW_PRODUCTS_IMAGES = 'view_products_images';

    private int $id;
    private string $product;
    private string $code;
    private string $short;
    private string $description;
    private string $price;

    public function setProps(array $vars): ProductModel
    {
        $this->id = !empty($vars['id']) ? $vars['id'] : 0;
        $this->product = !empty($vars['product']) ? $vars['product'] : '';
        $this->code = !empty($vars['code']) ? $vars['code'] : '';
        $this->short = !empty($vars['short']) ? $vars['short'] : '';
        $this->description = !empty($vars['description']) ? $vars['description'] : '';
        $this->price = !empty($vars['price']) ? convertCurrencyToDecimal($vars['price']) : '';

        return $this;
    }

    /**
     * Return DB products list.
     *
     * @param array $request
     * @param string $primaryKey
     * @param array $columns 
     * @return array
     */
    public function list(array $request, string $primaryKey, array $columns): array
    {
        return LibSSP::complex($request, $this->con, self::PRODUCTS, $primaryKey, $columns);
    }

    public function listProductsAll(array $request, string $primaryKey, array $columns, $where = ''): array
    {
        
        return LibSSP::complex($request, $this->con, self::VIEW_PRODUCTS_IMAGES, $primaryKey, $columns, $where);
    }

    public function getProduct(): array
    {
        
        $sql = 'SELECT * FROM ' . self::VIEW_PRODUCTS_IMAGES . ' WHERE id = :id';
        
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $this->id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetch($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function getProductsImages(): array
    {
        $sql = 'SELECT * FROM ' . self::PRODUCTS_IMAGES . ' WHERE products_id = :products_id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':products_id', $this->id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetchAll($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function addProduct(): int
    {

        if (!$this->product) {
            throw new Exception('Produto sem nome!');
            return 0;
        }

        $date_registry = date('Y-m-d');
        $sql = 'INSERT INTO ' . self::PRODUCTS . ' (product,code,short,description,price) VALUES (:product, :code, :short, :description, :price)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':product', $this->product, $this->con::PARAM_STR_CHAR, 200);
        $stmt->bindParam(':code', $this->code, $this->con::PARAM_STR_CHAR, 200);
        $stmt->bindParam(':short', $this->short, $this->con::PARAM_STR_CHAR, 250);
        $stmt->bindParam(':description', $this->description, $this->con::PARAM_STR);
        $stmt->bindParam(':price', $this->price, $this->con::PARAM_STR_CHAR, 10);
        if ($stmt->execute()) {
            return $this->con->lastInsertId();
        }

        return 0;
    }

    public function updateProduct(): int
    {

        if (!$this->id) {
            throw new Exception('Produto não encontrado!');
            return 0;
        }

        $date_registry = date('Y-m-d');
        $sql = 'UPDATE ' . self::PRODUCTS . ' SET product = :product, short = :short, description = :description, price = :price WHERE id = :id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $this->id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':product', $this->product, $this->con::PARAM_STR_CHAR, 200);
        $stmt->bindParam(':short', $this->short, $this->con::PARAM_STR_CHAR, 250);
        $stmt->bindParam(':description', $this->description, $this->con::PARAM_STR);
        $stmt->bindParam(':price', $this->price, $this->con::PARAM_STR_CHAR, 10);
        if ($stmt->execute()) {
            return $this->id;
        }

        return 0;
    }

    public function deleteProduct(int $id): bool
    {

        $sql = 'DELETE FROM ' . self::PRODUCTS . ' WHERE id = :id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $id, $this->con::PARAM_INT, 11);
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function deleteProductImageAll(int $id): bool
    {

        $sql = 'DELETE FROM ' . self::PRODUCTS_IMAGES . ' WHERE products_id = :id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $id, $this->con::PARAM_INT, 11);
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function deleteProductImageByNameId(int $products_id, string $url_image): bool
    {

        $sql = 'DELETE FROM ' . self::PRODUCTS_IMAGES . ' WHERE products_id = :products_id AND url_image = :url_image';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':products_id', $products_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':url_image', $url_image, $this->con::PARAM_STR_CHAR, 200);
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function addProductImage($products_id, $url_image): int
    {
        $url_image = str_replace(ROOT . DS, '', $url_image);

        $sql = 'INSERT INTO ' . self::PRODUCTS_IMAGES . ' (products_id, url_image) VALUES (:products_id, :url_image)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':products_id', $products_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':url_image', $url_image, $this->con::PARAM_STR_CHAR, 255);
        if ($stmt->execute()) {
            return $this->con->lastInsertId();
        }

        return 0;
    }
}
