<?php

namespace App;

use App\Lib\Alert;
use App\Lib\Session;
use League\Plates\Engine;

class AppView extends Engine
{

    protected $alert;
    protected $modal;

    public function print(string $template, array $args = []): void
    {
        $this->alert = Alert::get();
        $this->getModal();
        $this->addData(['alert' => $this->alert]);
        echo $this->render($template, $args);
    }

    public function setModal(string $btn = ''): void
    {
        if (!empty($btn)) {
            $this->modal = $btn;
            Session::set('modal', $this->modal);
        }
    }

    public function getModal(): void
    {
        $this->modal = Session::get('modal');
        $this->addData(['modal' => $this->modal]);
        Session::remove('modal');
    }
}
