<?php

namespace App\Lib;

class Session {
    // Inicia a sessão
    public static function start() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
    }

    // Define um valor na sessão
    public static function set($key, $value) {
        $_SESSION[$key] = $value;
    }

    // Obtém um valor da sessão
    public static function get($key) {
        return isset($_SESSION[$key]) ? $_SESSION[$key] : null;
    }

    // Remove um valor da sessão
    public static function remove($key) {
        if (isset($_SESSION[$key])) {
            unset($_SESSION[$key]);
        }
    }

    // Destroi a sessão
    public static function destroy() {
        if (session_status() != PHP_SESSION_NONE) {
            session_unset();
            session_destroy();
        }
    }
}