<?php
/** ORDER */
$router->namespace("App\Components\Order")->group('pedido');
$router->post("/", "OrderController:renderPreOrder", "render.order");
$router->post("/finalizar", "OrderController:finalizeOrder", "finalize.order");