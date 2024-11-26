<?php

namespace App\Lib;

class Alert
{

    const ALERTS_KEY = 'alert';

    static public function set(string $message, string $type, bool $dismissible = true)
    {
        $encode = base64_encode(json_encode([
            'message' => $message,
            'type' => $type,
            'dismissible' => $dismissible
        ]));

        Session::set(self::ALERTS_KEY, $encode);
    }

    static public function get(): array
    {

        $alert = Session::get(self::ALERTS_KEY);
        if (!empty($alert)) {
            Session::remove(self::ALERTS_KEY);
            return json_decode(base64_decode($alert), true);
        }
        return [];
    }
}
