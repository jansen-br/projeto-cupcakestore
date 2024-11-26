<?php
/** PRODUCT */
$router->namespace("App\Components\Product")->group('produto');
$router->get("/listar", "ProductController:list", "product.list");
$router->post("/obter", "ProductController:get", "product.get");
$router->put("/cadastrar", "ProductController:put", "product.put");
$router->delete("/apagar", "ProductController:delete", "product.delete");
$router->post("/imagem/subir", "ProductController:uploadImage", "product.uploadimage");