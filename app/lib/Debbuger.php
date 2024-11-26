<?php

namespace App\Lib;

class Debbuger
{

    static $debbuger;
    static $vars;

    static function setVars($vars)
    {
        self::$debbuger = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS);
        self::$vars[] = $vars;
    }

    static function print()
    {
        if (!empty(self::$vars)) {
            echo '<div class="m-2 position-absolute top-0 start-0 end-0 alert alert-danger alert-dismissible" role="alert" style="z-index: 10000">';
            echo '<h5 class="alert-heading">Debug</h5>';
            /*if(!empty(self::$debbuger)){
                foreach(self::$debbuger as $k){
                    echo '<div><small>' .$k['file']. '</small></div>';
                }
            }*/
            echo '<div>' . self::$debbuger[1]['file'] . ' (' . self::$debbuger[1]['line'] . ')</div>';
            echo '<hr>';
            echo '<div>';
            echo '<pre>';
            print_r(self::$vars);
            echo '</pre>';
            echo '<a class="btn-close" data-bs-dismiss="alert" aria-label="Close" href="javascript:void(0);"><span class="d-none">Fechar</span></a>';
            echo '</div>';
            echo '</div>';
        }
    }

    static function printInto($vars)
    {
        if (!empty($vars)) {
            echo '<h5 class="alert-heading">Debug</h5>';
            echo '<hr>';
            echo '<div>';
            echo '<pre>';
            print_r($vars);
            echo '</pre>';
            echo '</div>';
        }
    }
}
