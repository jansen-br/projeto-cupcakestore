<?php
/** ORDER */
$router->namespace("App\Components\Order")->group('pedido');
$router->post("/", "OrderController:renderPreOrder", "render.order");
$router->post("/finalizar", "OrderController:finalizeOrder", "finalize.order");
$router->post("/resumo", "OrderController:renderOrderSummary", "render.order.summary");
$router->post("/listar", "OrderController:listOrders", "list.orders");