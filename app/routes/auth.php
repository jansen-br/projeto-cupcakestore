<?php
$router->namespace("App\Components\Auth")->group('auth');
$router->post("/acessar", "AuthController:access", "auth.access");
$router->get("/sair", "AuthController:leave", "auth.leave");
