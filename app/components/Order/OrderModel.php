<?php

namespace App\Components\Order;

use App\AppModel;

class OrderModel extends AppModel
{
    const COSTUMER_ORDERS = 'costumer_orders';
    const ORDER_ITEMS = 'order_items';
    const VIEW_ORDER_ITEMS = 'view_order_items';

    public function getOrder(int $id, int $costumers_id)
    {
        $sql = 'SELECT * FROM ' . self::COSTUMER_ORDERS . ' WHERE id = :id AND costumers_id = :costumers_id';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetch($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function getLastOrder(int $costumers_id)
    {
        $sql = 'SELECT * FROM ' . self::COSTUMER_ORDERS . ' WHERE costumers_id = :costumers_id ORDER BY id DESC LIMIT 1';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetch($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function getOrderItems(int $costumer_orders_id)
    {
        $sql = 'SELECT * FROM ' . self::VIEW_ORDER_ITEMS . ' WHERE costumer_orders_id = :costumer_orders_id';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumer_orders_id', $costumer_orders_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetchAll($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }



    public function listOrders(int $costumers_id)
    {
        $sql = 'SELECT * FROM ' . self::COSTUMER_ORDERS . ' WHERE costumers_id = :costumers_id ORDER BY id DESC';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetchAll($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function registerOrder($costumers_id, $total_amount, $status, $address, $payment): int
    {

        $sql = 'INSERT INTO ' . self::COSTUMER_ORDERS . ' (costumers_id, total_amount, status, address, payment) VALUES (:costumers_id, :total_amount, :status, :address, :payment)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':total_amount', $total_amount, $this->con::PARAM_STR_CHAR, 10);
        $stmt->bindParam(':status', $status, $this->con::PARAM_STR_CHAR, 50);
        $stmt->bindParam(':address', $address, $this->con::PARAM_STR_CHAR, 550);
        $stmt->bindParam(':payment', $payment, $this->con::PARAM_STR_CHAR, 150);

        if ($stmt->execute()) {
            return $this->con->lastInsertId();
        }

        return 0;
    }

    public function registerOrderItems(int $products_id, int $costumer_orders_id, int $quantity, string $price, string $total): int
    {

        $sql = 'INSERT INTO ' . self::ORDER_ITEMS . ' (products_id, costumer_orders_id, quantity, price, total) VALUES (:products_id, :costumer_orders_id, :quantity, :price, :total)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':products_id', $products_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':costumer_orders_id', $costumer_orders_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':quantity', $quantity, $this->con::PARAM_INT, 4);
        $stmt->bindParam(':price', $price, $this->con::PARAM_STR_CHAR, 5);
        $stmt->bindParam(':total', $total, $this->con::PARAM_STR_CHAR, 6);


        if ($stmt->execute()) {
            return $this->con->lastInsertId();
        }

        return 0;
    }
}
