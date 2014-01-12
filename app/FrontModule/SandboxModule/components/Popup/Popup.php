<?php

namespace FrontModule\SandboxModule\Components;

use Bubo\Application\UI\Control;

use Nette\ComponentModel\IContainer;

/**
 *
 */
class Popup extends Control {

    const ASSIGN = 'assign';
    const BUY = 'buy';
    const REFERENCE = 'reference';

    protected $mode;

    protected $courseId;

    protected $termData;

    /**
     *
     * @param \Nette\ComponentModel\IContainer $parent
     * @param string $name
     * @param string $mode
     */
    public function __construct(IContainer $parent = NULL, $name = NULL, $mode) {
        parent::__construct($parent, $name);
        $this->mode = $mode;
    }

    public function setTermData($termData) {
        $this->termData = $termData;
        return $this;
    }

    /**
     *
     * @param string $name
     * @return \FrontModule\SandboxModule\Components\LoginFormPopup\Components\AssignForm
     */
    public function createComponentAssignForm($name) {
        $assignForm = new LoginFormPopup\Components\AssignForm($this, $name);
        $assignForm->setTermData($this->termData);
        return $assignForm;
    }

    public function createComponentBuyForm($name) {
        return new LoginFormPopup\Components\BuyForm($this, $name);
    }

    public function createComponentReferenceForm($name) {
        return new LoginFormPopup\Components\ReferenceForm($this, $name);
    }

    protected function getTitle() {
        $title = NULL;
        switch ($this->mode) {
            case self::ASSIGN:
                $title = "Přihlásit se na kurz";
                break;
            case self::BUY:
                $title = "Koupit kurz";
                break;
            case self::REFERENCE:
                $title = "Vložit referenci";
                break;
        }
        return $title;
    }

    protected function getTemplateFilename() {
        return sprintf('%s/templates/%s.latte',
                            __DIR__,
                            $this->mode);

    }

    public function setCourseId($courseId) {
        $this->courseId = $courseId;
    }

    public function getCourseId() {
        return $this->courseId;
    }

    /**
     * Rendering method
     */
    public function render() {
        $template = $this->initTemplate($this->getTemplateFilename());
        $data = array(
            'title' => $this->getTitle(),
            'html' => $template->__toString(),
        );
        echo json_encode($data);
    }

}

