<?php
/** COSTUMER */
$router->namespace("App\Components\Costumer")->group('cliente');
$router->post("/acessar_conta", "CostumerController:access", "costumer.access");
$router->put("/registrar_conta", "CostumerController:registre", "costumer.registre");
$router->get("/sair_conta", "CostumerController:leave", "costumer.leave");
// $router->post("/pagamento", "CostumerController:renderPayment", "costumer.render.payment");
$router->post("/mostrar_endereco_entrega", "CostumerController:renderAddressDelivery", "costumer.render.address.delivery");
$router->put("/registrar_endereco_entrega", "CostumerController:registreAddressDelivery", "costumer.registre.address.delivery");
$router->post("/definir_endereco_entrega", "CostumerController:setPreferedAddress", "costumer.set.prefered.address");
$router->delete("/remover_endereco_entrega", "CostumerController:removeAddress", "costumer.remove.address");
$router->post("/mostrar_forma_pagamento", "CostumerController:renderPaymentMethod", "costumer.render.payment.method");
$router->put("/registrar_forma_pagamento", "CostumerController:registreCreditCard", "costumer.registre.creditcard");
$router->post("/definir_forma_pagamento", "CostumerController:setPreferedCreditCard", "costumer.set.prefered.creditcard");
$router->delete("/remover_forma_pagamento", "CostumerController:removeCreditCard", "costumer.remove.creditcard");