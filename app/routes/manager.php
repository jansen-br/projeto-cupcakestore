<?php
// ADM START
$router->namespace("App\Pages\Manager")->group('gerente');
$router->get("/", "ManagerController:render", "manager");
$router->get("/login", "ManagerController:renderLogin", "manager.login");
$router->get("/produtos", "ManagerController:renderProducts", "manager.products");
