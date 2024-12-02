<?php

use App\Components\Costumer\CostumerController;
use App\Lib\Alert;
use App\Lib\Session;
use CoffeeCode\Router\Router;
use PHPUnit\Framework\TestCase;


class CostumerControllerTest extends TestCase
{
    private $costumerController;
    private $sessionMock;
    private $alertMock;
    private $routerMock;

    protected function setUp(): void
    {
        include_once "../../../config.php";
        // Mock da classe Session
        $this->sessionMock = $this->createMock(Session::class);
        // Mock da classe Alert
        $this->alertMock = $this->createMock(Alert::class);
        // Mock da classe Router
        $this->routerMock = $this->createMock(Router::class);
        // $this->costumerController->router = $this->routerMock;

        $this->costumerController = new CostumerController($this->routerMock);
        
    }

    public function testLeaveSessionRemovedAndAlertSet()
    {
        // Configurando o mock para simular a remoção da sessão
        $this->sessionMock->expects($this->once())
            ->method('remove')
            ->with('costumer')
            ->willReturn(true);

        // Configurando o mock para verificar se Alert::set foi chamado
        $this->alertMock->expects($this->once())
            ->method('set')
            ->with('Saiu da conta!', 'success');

        // Configurando o mock para verificar se a rota foi redirecionada
        $this->routerMock->expects($this->once())
            ->method('redirect')
            ->with('root');

        // Chamando o método leave()
        $this->costumerController->leave();
    }
}
