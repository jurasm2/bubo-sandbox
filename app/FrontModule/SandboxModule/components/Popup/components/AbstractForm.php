<?php

namespace FrontModule\SandboxModule\Components\LoginFormPopup\Components;

use Nette\Application\UI\Form;
use Nette\Utils\Html;
use Nette\ComponentModel\IContainer;
use Nette\Templating\FileTemplate;
use Nette\Latte\Engine as LatteEngine;
use Nette\Mail\Message as MailMessage;

abstract class AbstractForm extends Form {

    public function __construct(IContainer $parent = NULL, $name = NULL) {
        parent::__construct($parent, $name);
        $renderer = $this->getRenderer();
        $renderer->wrappers['controls']['container'] = NULL;
        $renderer->wrappers['pair']['container'] = Html::el('div', array('class' => 'input-container'));
        $renderer->wrappers['label']['container'] = NULL;
        $renderer->wrappers['control']['container'] = NULL;

        $this->getElementPrototype()->class[] = 'input-box-form';
    }

    protected function addPlaceholder($element, $text) {
        $element->getControlPrototype()->placeholder = $text;
    }

    protected function initEmailTemplate($templatePath) {
        $template = new FileTemplate($templatePath);
        $template->registerFilter(new LatteEngine);
        $template->registerHelperLoader('Nette\Templating\Helpers::loader');
        return $template;
    }

    protected function sendEmail($template, $emailParams) {
        $mail = new MailMessage;
        $mail->setFrom($emailParams['from'])
            ->setSubject($emailParams['subject'])
            ->setHtmlBody($template);

        foreach((array) $emailParams['to'] as $email) {
            $mail->addTo($email);
        }

        $mail->send();
    }

}