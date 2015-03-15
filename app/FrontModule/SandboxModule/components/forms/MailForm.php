<?php

namespace FrontModule\SandboxModule\Forms;

use Nette;
use Nette\Application\UI\Form;


class MailForm extends BaseForm
{
	public $to = 'jurasm2@gmail.com';
	public $subject = 'Kontakt z webové stranky';
	public $from = 'Tomas Wolf <info@tomaswolf.com>';
	public $templateFilename = 'contact.latte';

	public function __construct($parent, $name)
	{
		parent::__construct($parent, $name);
	}

	public function sendMail($formValues)
	{
		$template = new Nette\Templating\FileTemplate(__DIR__.'/emailTemplates/'.$this->templateFilename);
		$template->registerFilter(new Nette\Latte\Engine);
		$template->registerHelperLoader('Nette\Templating\Helpers::loader');

		$template->values = $formValues;

		$mail = new Nette\Mail\Message;
		$mail->setFrom($this->from)
			->setSubject($this->subject)
			->addTo($this->to)
			->setHtmlBody($template);

		$mailer = $this->presenter->context->getService('mail.mailer');
		$mailer->send($mail);
	}
}

