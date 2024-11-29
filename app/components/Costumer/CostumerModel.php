<?php

namespace App\Components\Costumer;

use App\AppModel;
use Exception;
use stdClass;

class CostumerModel extends AppModel
{

    const TB = 'costumers';
    const TB_ADDRESSES = 'costumer_addresses';
    const TB_CREDITCARD = 'costumer_creditcards';

    private $props;

    public function setProps(array $vars): CostumerModel
    {
        $this->props = new stdClass;

        $this->props->id = !empty($vars['id']) ? $vars['id'] : 0;
        $this->props->first_name = !empty($vars['first_name']) ? $vars['first_name'] : '';
        $this->props->last_name = !empty($vars['last_name']) ? $vars['last_name'] : '';
        $this->props->phone = !empty($vars['phone']) ? $vars['phone'] : '';
        $this->props->email = !empty($vars['email']) ? $vars['email'] : '';
        $this->props->account_password = !empty($vars['account_password']) ? $vars['account_password'] : '';

        return $this;
    }


    public function registre(): array
    {
        if (
            empty($this->props->first_name)
            || empty($this->props->first_name)
            || empty($this->props->last_name)
            || empty($this->props->email)
            || empty($this->props->account_password)
        ) {
            throw new Exception('Preenchimento incompleto!');
        }

        $password_hash = password_hash($this->props->account_password, PASSWORD_DEFAULT);

        $sql = 'INSERT INTO ' . self::TB . ' (first_name, last_name, email, phone, password_hash) VALUES (:first_name, :last_name, :email, :phone, :password_hash)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':first_name', $this->props->first_name, $this->con::PARAM_STR_CHAR, 50);
        $stmt->bindParam(':last_name', $this->props->last_name, $this->con::PARAM_STR_CHAR, 50);
        $stmt->bindParam(':phone', $this->props->phone, $this->con::PARAM_STR_CHAR, 100);
        $stmt->bindParam(':email', $this->props->email, $this->con::PARAM_STR_CHAR, 15);
        $stmt->bindParam(':password_hash', $password_hash, $this->con::PARAM_STR_CHAR, 50);

        if ($stmt->execute()) {
            $data = [
                'id' => $this->con->lastInsertId(),
                'first_name' => $this->props->first_name,
                'last_name' => $this->props->first_name,
                'phone' => $this->props->first_name
            ];
            return $data;
        }

        return [];
    }

    public function login(): array
    {
        $email = $this->props->email;
        $account_password = $this->props->account_password;

        $sql = 'SELECT * FROM ' . self::TB . ' WHERE email = :email';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':email', $email, $this->con::PARAM_STR_CHAR, 150);
        $stmt->execute();
        $data = $stmt->fetch($this->con::FETCH_ASSOC);

        if (!empty($data) && password_verify($account_password, $data['password_hash'])) {
            unset($data['password_hash']);
            return $data;
        }

        return [];
    }

    public function getAddresses(): array
    {

        $sql = 'SELECT * FROM ' . self::TB_ADDRESSES . ' WHERE costumers_id = :costumers_id';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $this->props->id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetchAll($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function getPreferedAddress(int $costumers_id): array
    {

        $sql = 'SELECT * FROM ' . self::TB_ADDRESSES . ' WHERE costumers_id = :costumers_id AND prefered = 1';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetch($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function registreAddress(int $costumers_id, string $postal_code, string $address, string $neighborhood, string $city, string $state): bool
    {

        $sql = 'INSERT INTO ' . self::TB_ADDRESSES . ' (costumers_id, postal_code, address, neighborhood, city, state) VALUES (:costumers_id, :postal_code, :address, :neighborhood, :city, :state)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':postal_code', $postal_code, $this->con::PARAM_STR_CHAR, 9);
        $stmt->bindParam(':address', $address, $this->con::PARAM_STR_CHAR, 100);
        $stmt->bindParam(':neighborhood', $neighborhood, $this->con::PARAM_STR_CHAR, 100);
        $stmt->bindParam(':city', $city, $this->con::PARAM_STR_CHAR, 100);
        $stmt->bindParam(':state', $state, $this->con::PARAM_STR_CHAR, 2);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function setPreferedAddress(int $costumers_id, int $address_id)
    {

        $sql = 'UPDATE ' . self::TB_ADDRESSES . ' SET prefered = 0 WHERE costumers_id = :costumers_id; ';
        $sql .= 'UPDATE ' . self::TB_ADDRESSES . ' SET prefered = 1 WHERE id = :address_id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':address_id', $address_id, $this->con::PARAM_INT, 11);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function removeAddress(int $id): bool
    {

        $sql = 'DELETE FROM ' . self::TB_ADDRESSES . ' WHERE id = :id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $id, $this->con::PARAM_INT, 11);
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function registreCreditCard(int $costumers_id, string $number, string $flag): bool
    {

        $sql = 'INSERT INTO ' . self::TB_CREDITCARD . ' (costumers_id, number, flag) VALUES (:costumers_id, :number, :flag)';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':number', $number, $this->con::PARAM_STR_CHAR, 16);
        $stmt->bindParam(':flag', $flag, $this->con::PARAM_STR);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function getCreditCards(int $costumers_id): array
    {

        $sql = 'SELECT id, costumers_id, number, flag, prefered FROM ' . self::TB_CREDITCARD . ' WHERE costumers_id = :costumers_id';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetchAll($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function getPreferedCreditCard(int $costumers_id): array
    {

        $sql = 'SELECT id, costumers_id, number, flag, prefered FROM ' . self::TB_CREDITCARD . ' WHERE costumers_id = :costumers_id AND prefered = 1';

        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->execute();

        if ($data = $stmt->fetch($this->con::FETCH_ASSOC)) {
            return $data;
        }
        return [];
    }

    public function setPreferedCreditCard(int $costumers_id, int $address_id)
    {

        $sql = 'UPDATE ' . self::TB_CREDITCARD . ' SET prefered = 0 WHERE costumers_id = :costumers_id; ';
        $sql .= 'UPDATE ' . self::TB_CREDITCARD . ' SET prefered = 1 WHERE id = :address_id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':costumers_id', $costumers_id, $this->con::PARAM_INT, 11);
        $stmt->bindParam(':address_id', $address_id, $this->con::PARAM_INT, 11);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function removeCreditCard(int $id): bool
    {

        $sql = 'DELETE FROM ' . self::TB_CREDITCARD . ' WHERE id = :id';
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':id', $id, $this->con::PARAM_INT, 11);
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }
}
