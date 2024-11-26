<?php

namespace App\Lib;

class ImageUploader {
    private $targetDir;
    private $allowedTypes = ['jpg', 'jpeg', 'png', 'gif'];

    public function __construct($targetDir = "uploads/") {
        $this->targetDir = $targetDir;
    }

    public function upload($file) {
        $fileName = basename($file["name"]);
        $targetFilePath = $this->targetDir . '/' . $fileName;
        $fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION);

        // Check if file type is allowed
        if (in_array(strtolower($fileType), $this->allowedTypes)) {
            // Upload file to server
            if (move_uploaded_file($file["tmp_name"], $targetFilePath)) {
                return "The file " . $fileName . " has been uploaded.";
            } else {
                return "Sorry, there was an error uploading your file.";
            }
        } else {
            return "Sorry, only JPG, JPEG, PNG, & GIF files are allowed.";
        }
    }
}

?>
