<?php

namespace App\Components\Auth;

use App\AppModel;
use stdClass;

class AuthModel extends AppModel
{
    const TB = 'managers';

    private $props;

    public function setProps(array $vars): AuthModel
    {
        $this->props = new stdClass;

        $this->props->username = !empty($vars['username']) ? $vars['username'] : '';
        $this->props->account_password = !empty($vars['account_password']) ? $vars['account_password'] : '';

        return $this;
    }

    public function login(): array
    {
        $username = $this->props->username;
        $account_password = $this->props->account_password;

        $sql = 'SELECT * FROM ' . self::TB . ' WHERE username = :username';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':username', $username, $this->con::PARAM_STR_CHAR, 150);
        $stmt->execute();
        $data = $stmt->fetch($this->con::FETCH_ASSOC);

        if (!empty($data) && password_verify($account_password, $data['password_hash'])) {
            return [
                'username' => $username,
                'access' => true];
        }

        return [];
    }
}
