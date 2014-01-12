<?php

namespace Model;

/**
 * Description of ReferencesModel
 *
 * @author jurasm2
 */
class ReferencesModel extends BaseModel {

    public function getReferences($lang) {
        return $this->connection->fetchAll('SELECT * FROM [wolf_references] %if WHERE [lang] = %s', $lang != 'cs', $lang);
    }

    public function addReference($data) {
        return $this->connection->query('INSERT INTO [wolf_references]', $data);
    }

    public function removeReference($refId) {
        return $this->connection->query('DELETE FROM [wolf_references] WHERE [id] = %i', $refId);
    }
}

