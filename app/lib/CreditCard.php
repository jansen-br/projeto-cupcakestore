<?php

namespace App\Lib;

class CreditCard{
    
    public static function getCardBrand($cardNumber) {
        $cardNumber = preg_replace('/[^0-9]/', '', $cardNumber); // Remove espaços e outros caracteres não numéricos
    
        $brands = [
            'visa' => '/^4[0-9]{12}(?:[0-9]{3})?$/',
            'mastercard' => '/^5[1-5][0-9]{14}$/',
            'amex' => '/^3[47][0-9]{13}$/',
            'diners_club' => '/^3(?:0[0-5]|[68][0-9])[0-9]{11}$/',
            'discover' => '/^6(?:011|5[0-9]{2})[0-9]{12}$/',
            'jcb' => '/^(?:2131|1800|35\d{3})\d{11}$/'
        ];
    
        foreach ($brands as $brand => $pattern) {
            if (preg_match($pattern, $cardNumber)) {
                return $brand;
            }
        }
    
        return 'unknown';
    }
     
}