<?php

namespace BuboApp\FrontModule\SandboxModule;

use BuboApp;

use FrontModule\SandboxModule\Components\Popup;
use FrontModule\SandboxModule\Components\PriceTicket;

class DefaultPresenter extends BuboApp\FrontModule\DefaultPresenter {

     /**
     * Frontend dispatcher
     *
     * @param type $url - url (without first slash)
     */
    public function actionDefault($lang, $url) {
        $this->loadPage($lang, $url);
    }

    public function createComponentReferenceList() {
        return new \FrontModule\SandboxModule\Components\ReferencesList();
    }

    public function createComponentReferencePopup($name) {
        return new Popup($this, $name, Popup::REFERENCE);
    }

    public function createComponentPriceTicket($name) {
        return new PriceTicket($this, $name);
    }

    public function handleAddReference() {
        echo $this['referencePopup']->render();
        die();
    }

    public function createComponentBuyPopup($name) {
        return new Popup($this, $name, Popup::BUY);
    }

    public function handleBuyCourse($courseId) {
        $this['buyPopup']->setCourseId($courseId);
        echo $this['buyPopup']->render();
        die();
    }

}