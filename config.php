<?php

/**
 * Globals Configurations
 */
define('ROOT', __DIR__);

define('DS', DIRECTORY_SEPARATOR);

define("DB_CONFIG", [
    'cupcakestore' => [
        "driver" => "mysql",
        "host" => "localhost",
        "port" => "3306",
        "dbname" => "cupcakestore",
        "username" => "root",
        "passwd" => "",
        "options" => [
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
            PDO::ATTR_CASE => PDO::CASE_NATURAL
        ]
    ],
    'hostinger_cupcakestore' => [
        "driver" => "mysql",
        "host" => "srv1659.hstgr.io",
        "port" => "3306",
        "dbname" => "u343299778_cupcakestore",
        "username" => "u343299778_cakelovers",
        "passwd" => "Cupcake@bsb.24",
        "options" => [
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
            PDO::ATTR_CASE => PDO::CASE_NATURAL
        ]
    ]
]);

define('SCHEMA', 'cupcakestore');

define('HOST', 'http://local.cupcake.com.br');
// define('HOST', 'https://cupcakestore.org');

define('APP', ROOT . DS . 'app');

define('THEMES', ROOT . DS . 'themes');

define('ASSETS', ROOT . DS . 'assets');

define('TIMEZONE', 'America/Sao_Paulo');

// define('IMAGE_FOLDER', __DIR__ . '/../@data');

define('DEFAULT_LANG', 'pt-br');

// Define PHP timezone.
date_default_timezone_set(TIMEZONE);

define("MAIL", [
    "host" => "smtp.gmail.com",
    "port" => 465,
    "from_name" => "cupcake",
    "from_email" => "cupcakestore@local.cupcake.com",
    "user" => "cupcakestore@local.cupcake.com",
    "password" => ""
]);


/**
 * AUTOLOAD
 */
// Define loader autoload.
$loader = require ROOT . DS . 'vendor/autoload.php';
// Define app classes folder using autoload composer.
$loader->addPsr4('App\\', ROOT . DS . 'app/');
include_once 'functions.php';
