<?php
// PRINCIPAL
$router->namespace("App\Pages\Root")->group(null);
$router->get("/", "RootController:render", "root");
