<?php

namespace App\Lib;

class FileManager
{

    const DIRETORY_ROOT = ASSETS . DS . "/@img";

    function listFilesAndDirectories($directory = "", $baseDir = "")
    {
        if(empty($baseDir)){
            return null;
        }
        
        $baseDir = realpath($baseDir);
        // Verificar se o diretório existe e está dentro do diretório base
        if (is_dir($baseDir . $directory) && strpos(realpath($baseDir . $directory), $baseDir) === 0) {
            // Abrir o diretório
            if ($dh = opendir($baseDir . $directory)) {
                // Verificar se não estamos na raiz para adicionar link para o diretório pai
                if ($baseDir . $directory != $baseDir) {
                    $parentDir = dirname($baseDir . $directory);
                    // Garantir que o diretório pai está dentro do diretório base
                    if (strpos(realpath($parentDir), $baseDir) === 0) {
                        $relativeParentDir = str_replace($baseDir, '', $parentDir);
                        echo "<a href=\"?dir=$relativeParentDir\">[Voltar]</a><br>";
                    }
                }

                // Ler os arquivos e pastas dentro do diretório
                while (($file = readdir($dh)) !== false) {
                    // Ignorar os diretórios . e ..
                    if ($file !== '.' && $file !== '..') {
                        
                        $fullPath = $baseDir . $directory . '/' . $file;
                        $relativePath = str_replace($baseDir, '', $fullPath);

                        if (is_dir($fullPath)) {
                            // Criar um link para a subpasta
                            echo "<a href=\"?dir=$relativePath\">[Diretório] $file</a><br>";
                        } elseif (is_file($fullPath)) {
                            echo "Arquivo: $file<br>";
                        }
                    }
                }
                // Fechar o diretório
                closedir($dh);
            } else {
                echo "Não foi possível abrir o diretório.";
            }
        } else {
            echo "O diretório não existe ou está fora do escopo permitido.";
        }
    }
}
