<?php

namespace App\Lib;

use Exception;
use stdClass;

class FileManager
{
    private $baseDir;
    private object $tree;

    public function __construct($baseDir)
    {
        $this->baseDir = realpath($baseDir);
        $this->tree = new stdClass;
    }

    public function listFilesAndDirectories($directory = ""): object
    {
        if (!$this->isValidDirectory($directory)) {
            throw new Exception("Diretório inválido ou fora do escopo permitido.");
        }

        $currentDir = $this->baseDir . $directory;
        
        if ($dh = opendir($currentDir)) {
            $this->generateParentLink($directory);
            
            while (($file = readdir($dh)) !== false) {
                if ($file !== '.' && $file !== '..') {
                    $this->renderItem($directory, $file);
                    
                }
            }
            closedir($dh);
            return $this->tree;
        } else {
            throw new Exception("Não foi possível abrir o diretório.");
        }
    }

    private function isValidDirectory($directory)
    {
        $path = realpath($this->baseDir . $directory);
        return is_dir($path) && strpos($path, $this->baseDir) === 0;
    }

    private function generateParentLink($directory)
    {
        if ($directory != "") {
            $parentDir = dirname($this->baseDir . $directory);
            if (strpos(realpath($parentDir), $this->baseDir) === 0) {
                $relativeParentDir = str_replace($this->baseDir, '', $parentDir);
                $this->tree->directory = [
                    'local' => $directory,
                    'parent' => $relativeParentDir
                ];
            }
        }
    }

    private function renderItem($directory, $file)
    {
        $fullPath = $this->baseDir . $directory . '/' . $file;
        $relativePath = str_replace($this->baseDir, '', $fullPath);
        
        // $this->tree->item = [];
        
        if (is_dir($fullPath)) {
            $this->tree->item[] = [
                'label' => $file,
                'path' => $relativePath,
                'type' => 'directory',
                'code' => '0'
            ];
        } elseif (is_file($fullPath)) {
            $this->tree->item[] = [
                'label' => $file,
                'path' => $relativePath,
                'type' => 'file',
                'code' => '1'
            ];
        }

    }

    public function createDirectory($directoryName, $path = "")
    {
        $fullPath = $this->baseDir . $path . '/' . $directoryName;
        
        if (!$this->isValidDirectory($path)) {
            throw new Exception("Caminho de destino inválido ou fora do escopo permitido.");
        }

        if (!mkdir($fullPath, 0755)) {
            throw new Exception("Erro ao criar o diretório.");
        }

        echo "Diretório '$directoryName' criado com sucesso.";
    }

    public function deleteItem($path)
    {
        $fullPath = $this->baseDir . $path;

        if (strpos(realpath($fullPath), $this->baseDir) !== 0) {
            throw new Exception("Operação fora do escopo permitido.");
        }

        if (is_dir($fullPath)) {
            $this->deleteDirectory($fullPath);
        } elseif (is_file($fullPath)) {
            if (!unlink($fullPath)) {
                throw new Exception("Erro ao deletar o arquivo.");
            }
            echo "Arquivo deletado com sucesso.";
        } else {
            throw new Exception("Arquivo ou diretório não encontrado.");
        }
    }

    private function deleteDirectory($dirPath)
    {
        if (!is_dir($dirPath)) {
            return;
        }

        foreach (scandir($dirPath) as $item) {
            if ($item == '.' || $item == '..') {
                continue;
            }

            $itemPath = $dirPath . DIRECTORY_SEPARATOR . $item;
            if (is_dir($itemPath)) {
                $this->deleteDirectory($itemPath);
            } else {
                unlink($itemPath);
            }
        }

        rmdir($dirPath);
        echo "Diretório deletado com sucesso.";
    }
}
