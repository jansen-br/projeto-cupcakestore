<?php

use App\Lib\Debbuger;

function dd(...$vars): void
{
    Debbuger::setVars($vars);
}

function de(...$vars): void
{
    Debbuger::printInto($vars);
}

function convertCurrencyToDecimal($currency): float
{
    $currency = str_replace(',', '.', $currency);
    // Remover símbolos de moeda e outros caracteres não numéricos 
    $cleaned = preg_replace('/[^\d.]/', '', $currency);
    // Converter para decimal (número de ponto flutuante) 
    return number_format((float)$cleaned, 2, '.', '');
}

function convertDecimalToCurrency($decimal, $currencySymbol = ''): string
{
    // Formatar o número como moeda 
    $formatted = number_format($decimal, 2, ',', '.');
    // Adicionar o símbolo da moeda 
    return (!empty($currencySymbol) ? $currencySymbol . ' ' : '') . $formatted;
}
