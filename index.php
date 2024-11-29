<?php
// Import configuration file.
require_once 'config.php';


use CoffeeCode\Router\Router;

// Define object router and local url.
$router = new Router(HOST);

foreach (glob( APP. DS . "routes/*.php") as $filename) { 
    include $filename; 
}

// ERROR
// $router->namespace("App\Modules\Error")->group("error");
// $router->get("/{type}", "ErrorController:renderError", "error");

// EXEC ROUTER
$router->dispatch();

// ERROR
if ($router->error()) {
    echo 'error';
}

