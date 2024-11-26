function convertCurrencyToDecimal(currency) {
    // Remover símbolos de moeda e outros caracteres não numéricos
    const cleaned = currency.replace(/[^\d.-]/g, '');
    // Converter para decimal
    return parseFloat(cleaned).toFixed(2);
}

function convertDecimalToCurrency(value, currencySymbol = null) {
    let decimal = parseFloat(value);
    // Formatar o número como moeda
    const formatted = decimal.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    // Adicionar o símbolo da moeda
    return (currencySymbol ? currencySymbol + ' ' : '') + formatted;
}
