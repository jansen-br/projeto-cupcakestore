<?php
$router->namespace("App\Components\Cart")->group('carrinho');
$router->post("/adicionar", "CartController:add", "cart.add");
$router->post("/mostrar", "CartController:show", "cart.show");
$router->post("/excluir", "CartController:remove", "cart.remove");

