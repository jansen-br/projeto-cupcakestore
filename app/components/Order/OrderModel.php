<?php

namespace App\Components\Order;

use App\AppModel;

class OrderModel extends AppModel
{
    const COSTUMER_ORDERS = 'costumer_orders';
    const ORDER_ITEMS = 'order_items';

    public function registerOrder($costumers_id, $total_amount, $status): int
    {

        $sql = 'INSERT INTO ' . self::COSTUMER_ORDERS . ' (costumers_id, total_amount, status) VALUES (:costumers_id, :total_amount, :status)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':total_amount', $total_amount, $this->con::PARAM_STR_CHAR, 10);
        $stmt->bindParam(':status', $status, $this->con::PARAM_STR_CHAR, 50);

        if ($stmt->execute()) {
            return $this->con->lastInsertId();
        }

        return 0;
    }

    public function registerOrderItems(int $quantity, string $price_unit, int $products_id, int $costumer_orders_id): int
    {

        $sql = 'INSERT INTO ' . self::ORDER_ITEMS . ' (quantity, price_unit, products_id, costumer_orders_id) VALUES (:quantity, :price_unit, :products_id, :costumer_orders_id)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':quantity', $quantity, $this->con::PARAM_INT, 4);
        $stmt->bindParam(':price_unit', $price_unit, $this->con::PARAM_STR_CHAR, 5);
        $stmt->bindParam(':products_id', $products_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':costumer_orders_id', $costumer_orders_id, $this->con::PARAM_INT, 11);

        if ($stmt->execute()) {
            return $this->con->lastInsertId();
        }

        return 0;
    }
}
