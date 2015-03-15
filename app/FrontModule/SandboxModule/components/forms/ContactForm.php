<?php

namespace FrontModule\SandboxModule\Forms;

use Nette\Application\UI\Form;

class ContactForm extends MailForm
{

	public function __construct($parent, $name)
	{
		parent::__construct($parent, $name);

		$this->addText('name', 'Jméno')
			->setRequired('Zadejte, prosím, Vaše jméno');

		$this->addText('email', 'E-mail')
			->addRule(Form::EMAIL, 'Email není ve správném formátu')
			->setRequired('Zadejte, prosím, Váš email');

		$this->addTextArea('message', 'Zpráva')
			->addRule(Form::MAX_LENGTH, 'Maximální dálka zprávy je %d znaků', 500)
			->setRequired('Zadejte, prosím, text zprávy');

		$this->addText('reference', 'Jak jste se o mně dozvěděli?');

		$this->addSubmit('send','Odeslat');

		$this['name']->getControlPrototype()->class = 'form-control';
		$this['email']->getControlPrototype()->class = 'form-control';
		$this['message']->getControlPrototype()->class = 'form-control';
		$this['message']->getControlPrototype()->cols = 30;
		$this['message']->getControlPrototype()->rows = 5;
		$this['reference']->getControlPrototype()->class = 'form-control';

		$this['send']->getControlPrototype()->class = 'btn btn-primary btn-block';

		$this->onSuccess[] = array($this, 'formSubmitted');
	}


	public function formSubmitted($form)
	{

		$formValues = $form->getValues();

		$this->subject = 'Odeslaný kontaktní formulář';
		$this->templateFilename = 'contact.latte';
		$this->sendMail($formValues);

		$this->presenter->flashMessage('Zpráva byla úspěšně odeslána.');
		$this->presenter->redirect('this');

	}


}


