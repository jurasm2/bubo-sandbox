<?php

namespace FrontModule\SandboxModule\Components\LoginFormPopup\Components;

use Nette\Forms\Form;

/**
 * Description of BuyForm
 *
 */
class ReferenceForm extends AbstractForm {

    public function __construct($parent, $name) {
        parent::__construct($parent, $name);

        $this->addGroup();

        $this->addText('name', 'Jméno')
                ->setRequired();

        $this->addText('email', 'Email')
                ->addCondition(Form::FILLED)
                    ->addRule(Form::EMAIL);

        $this->addTextArea('message', 'Text')
                ->setRequired();

        $this->addHidden('lang', $this->presenter->getFullLang());

        $this->addPlaceholder($this['name'], 'Vaše jméno');
        $this->addPlaceholder($this['email'], 'Nepovinný udaj');
        $this->addPlaceholder($this['message'], 'Zde napište svůj názor. Děkuji Vám');

        $this->addSubmit('send','Odeslat');
        $this->onSuccess[] = array($this, 'formSubmited');
    }

    /**
     * Add reference to database and send email about that
     * @param type $form
     */
    public function formSubmited($form) {
        $formValues = $form->getValues();

        $model = $this->presenter->context->modelLoader->loadModel('ReferencesModel');
        $model->addReference($formValues);

        $this->presenter->flashMessage('Reference byla vložena.');
        $this->presenter->redirect('this');
    }

}