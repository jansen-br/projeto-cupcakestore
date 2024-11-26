<?php

namespace App\Lib;

use Exception;

class ImageUploader2
{
    private $uploadDirectory;
    private $newWidth;
    private $newHeight;

    public function __construct($uploadDirectory, $newWidth = 800, $newHeight = 600)
    {
        $this->uploadDirectory = $uploadDirectory;
        $this->newWidth = $newWidth;
        $this->newHeight = $newHeight;

        // Criar o diretório de upload se não existir
        if (!is_dir($this->uploadDirectory)) {
            mkdir($this->uploadDirectory, 0777, true);
        }
    }

    public function uploadImage($image_name, $image_tmp_name, $prefix = "", $thumbnail = true): string
    {

        if (isset($image_name)) {
            // $totalFiles = count($images['name']);

            // for ($i = 0; $i < $totalFiles; $i++) {
            $fileName = $image_name;
            $file_extension = pathinfo($fileName, PATHINFO_EXTENSION);
            $new_name = $prefix . '_' . uniqid() . '.' . $file_extension;
            $targetFilePath = $this->uploadDirectory . '/' . $new_name;

            // Caminho temporário do arquivo
            $tempFilePath = $image_tmp_name;

            // Redimensionar e centralizar a imagem antes de salvar
            $this->resizeAndCenterImage($tempFilePath, $targetFilePath, $this->newWidth, $this->newHeight);

            // echo "Imagem {$fileName} redimensionada e enviada com sucesso.<br>";
            return $new_name;
            // }
        }

        return "";
    }

    // private function resizeAndCenterImage($sourcePath, $targetPath, $newWidth, $newHeight)
    // {
    //     list($origWidth, $origHeight) = getimagesize($sourcePath);
    //     $image_p = imagecreatetruecolor($newWidth, $newHeight);
    //     $image = imagecreatefromjpeg($sourcePath);

    //     // Calcular a proporção
    //     $ratioOrig = $origWidth / $origHeight;
    //     $ratioNew = $newWidth / $newHeight;

    //     if ($ratioNew > $ratioOrig) {
    //         // Nova altura será baseada na altura do novo tamanho
    //         $tempWidth = $newHeight * $ratioOrig;
    //         $tempHeight = $newHeight;
    //     } else {
    //         // Nova largura será baseada na largura do novo tamanho
    //         $tempHeight = $newWidth / $ratioOrig;
    //         $tempWidth = $newWidth;
    //     }

    //     // Calcular o centro da nova imagem
    //     $x = ($newWidth - $tempWidth) / 2;
    //     $y = ($newHeight - $tempHeight) / 2;

    //     // Preencher com cor de fundo (branco)
    //     $white = imagecolorallocate($image_p, 255, 255, 255);
    //     imagefilledrectangle($image_p, 0, 0, $newWidth, $newHeight, $white);

    //     // Redimensionar e centralizar a imagem
    //     imagecopyresampled($image_p, $image, $x, $y, 0, 0, $tempWidth, $tempHeight, $origWidth, $origHeight);

    //     // Salvar a nova imagem
    //     imagejpeg($image_p, $targetPath, 100);

    //     // Limpar memória
    //     imagedestroy($image_p);
    //     imagedestroy($image);
    // }

    private function resizeAndCenterImage($sourcePath, $targetPath, $newWidth, $newHeight)
    {
        list($origWidth, $origHeight) = getimagesize($sourcePath);
        $image_p = imagecreatetruecolor($newWidth, $newHeight);
        $image = imagecreatefromjpeg($sourcePath);

        // Calcular a proporção original e a nova proporção
        $ratioOrig = $origWidth / $origHeight;
        $ratioNew = $newWidth / $newHeight;

        if ($ratioNew > $ratioOrig) {
            // Basear-se na largura (altura será cortada)
            $tempWidth = $newWidth;
            $tempHeight = $newWidth / $ratioOrig;
            $x = 0; // Alinhamento horizontal
            $y = ($newHeight - $tempHeight) / 2; // Centralizar verticalmente
        } else {
            // Basear-se na altura (largura será cortada)
            $tempHeight = $newHeight;
            $tempWidth = $newHeight * $ratioOrig;
            $x = ($newWidth - $tempWidth) / 2; // Centralizar horizontalmente
            $y = 0; // Alinhamento vertical
        }

        // Preencher com cor de fundo (opcional: branco)
        $white = imagecolorallocate($image_p, 255, 255, 255);
        imagefilledrectangle($image_p, 0, 0, $newWidth, $newHeight, $white);

        // Redimensionar e centralizar com corte
        imagecopyresampled(
            $image_p,
            $image,
            $x,
            $y,               // Posição onde a imagem será desenhada
            0,
            0,                 // Origem da imagem original
            $tempWidth,
            $tempHeight, // Dimensões de destino
            $origWidth,
            $origHeight  // Dimensões originais
        );

        // Salvar a nova imagem
        imagejpeg($image_p, $targetPath, 100);

        // Limpar memória
        imagedestroy($image_p);
        imagedestroy($image);
    }


    public function deleteImage($file_name)
    {
        $file_path = $this->uploadDirectory . '/' . $file_name;
        if (file_exists($file_path)) {
            return unlink($file_path); // Apaga o arquivo
        }
        return false;
    }
}
