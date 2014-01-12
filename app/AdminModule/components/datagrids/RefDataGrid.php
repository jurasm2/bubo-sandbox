<?php

namespace BuboApp\AdminModule\DataGrids;


final class RefDataGrid extends BaseDataGrid {

    public function __construct($parentPresenter) {
        parent::__construct($parentPresenter);

        // Create a query
        $ds = $this->connection->dataSource("SELECT
                                                *
                                                FROM
                                                    [wolf_references]
                                            ");


        // Create a data source
        $dataSource = new \DataGrid\DataSources\Dibi\DataSource($ds);

        // Configure data grid

        $this->setDataSource($dataSource);

        // Configure columns
        //$this->addNumericColumn('id', 'ID')->getHeaderPrototype()->style('width: 50px');

        $this->addColumn('id', 'Id');
        $this->addColumn('lang', 'Kód');
        $this->addColumn('message', 'Zpráva');
        $this->addColumn('created', 'Vytvořeno');

        $this['message']->formatCallback[] = function ($value) {
            return (mb_substr($value, 0, 50, 'utf-8') . '...');
        };

        $this->keyName = 'id';
        $this->addActionColumn('Actions');

        $icon = \Nette\Utils\Html::el('span');

        $this->addAction('Odinstalovat', 'refConfirmDialog:confirmDelete!', clone $icon->class('icon icon-del')->setText('Odstranit referenci'), TRUE);

    }


}
