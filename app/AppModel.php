<?php

namespace App;

use PDO;
use PDOException;

class AppModel
{
    protected object $con;

    public function __construct()
    {
        $this->init();
    }

    private function init()
    {
        if (empty($this->con)) {

            // $db_cfg = DB_CONFIG['_default'];

            if (defined('SCHEMA')) {
                $db_cfg = DB_CONFIG[SCHEMA];
            }

            try {
                $con = new PDO(
                    $db_cfg["driver"] . ":host=" . $db_cfg["host"] . ";dbname=" . $db_cfg["dbname"] . ";port=" . $db_cfg["port"],
                    $db_cfg["username"],
                    $db_cfg["passwd"],
                    $db_cfg["options"]
                );
                $this->con = $con;
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }
    }
}
