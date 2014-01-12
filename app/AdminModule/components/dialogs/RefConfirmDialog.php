<?php

namespace BuboApp\AdminModule\Dialogs;

final class RefConfirmDialog extends BaseConfirmDialog {

    public function __construct($parentPresenter, $name) {
        parent::__construct($parentPresenter, $name);

        $this->buildConfirmDialog();
    }

    public function buildConfirmDialog() {

        $this
                ->addConfirmer(
                        'delete', // název signálu bude 'confirmDelete!'
                        array($this, 'deleteItem'), // callback na funkci při kliku na YES
                        'Opravdu odstranit referenci?' // otázka (může být i callback vracející string)
                );

    }

    public function deleteItem($refId) {
        $result = $this->presenter->referencesModel->removeReference($refId);

        $this->presenter->flashMessage("Reference byla smazána");
        $this->presenter->redirect('this');

    }




}