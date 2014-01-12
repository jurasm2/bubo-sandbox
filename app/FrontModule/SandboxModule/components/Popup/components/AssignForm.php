<?php

namespace FrontModule\SandboxModule\Components\LoginFormPopup\Components;

use Nette\Forms\Form;

/**
 *
 */
class AssignForm extends AbstractForm {

    public function setTermData($termData) {
        $this['data']->setDefaultValue($termData);
        return $this;
    }

    public function __construct($parent, $name) {
        parent::__construct($parent, $name);

        $this->addGroup();
        $this->addText('voucher_number', 'Číslo voucheru')
            ->setRequired()
            ->addRule(Form::MAX_LENGTH, NULL, 50);

        $this->addText('name', 'Jméno')
            ->setRequired()
            ->addRule(Form::MAX_LENGTH, NULL, 100);

        $this->addText('email', 'Email')
            ->setRequired()
            ->addRule(Form::EMAIL)
            ->addRule(Form::MAX_LENGTH, NULL, 100);

        $this->addText('phone', 'Telefon');

        $this->addHidden('data');

        $this->addPlaceholder($this['name'], 'Vaše jméno');
        $this->addPlaceholder($this['phone'], 'Nepovinný udaj');

        $this->addSubmit('send','Odeslat');
        $this->onSuccess[] = array($this, 'formSubmited');
    }

    public function formSubmited($form) {
        $formValues = $form->getValues();

        // send email to admin
        $emailTemplate = $this->initEmailTemplate(__DIR__.'/emailTemplates/assign.latte');
        $emailTemplate->values = $formValues;
        $emailTemplate->termData = json_decode($formValues['data']);
        $this->sendEmail($emailTemplate, array(
            'from'  =>  "noreply@nauctesefotografovat.cz",
            'subject' => "Přihlášení na kurz nauctesefotografovat.cz",
            'to' => array(
                'jurasm2@gmail.com',
            ),
        ));

        // send email to client
        $clientEmailTemplate = $this->initEmailTemplate(__DIR__.'/emailTemplates/assign_to_client.latte');
        $this->sendEmail($clientEmailTemplate, array(
            'from'  =>  "noreply@nauctesefotografovat.cz",
            'subject' => "Přihlášení na kurz nauctesefotografovat.cz",
            'to' => array(
                $formValues['email'],
            ),
        ));

        $this->presenter->flashMessage('Formulář byl úspěšně odeslán.');
        $this->presenter->redirect('this');
        //$this->presenter->invalidateControl();

    }

}