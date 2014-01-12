<?php

namespace BuboApp\AdminModule;

final class ReferencesPresenter extends BasePresenter {

    public function renderManageLabelExtensions($labelId) {
        $this->labelId = $labelId;
        $this->template->labelId = $labelId;
    }


    public function renderEditLabel($labelId) {
        $this->template->labelId = $labelId;
    }

}
