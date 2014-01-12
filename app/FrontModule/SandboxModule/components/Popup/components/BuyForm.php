<?php

namespace FrontModule\SandboxModule\Components\LoginFormPopup\Components;

use Nette\Forms\Form;

/**
 * Description of BuyForm
 *
 */
class BuyForm extends AbstractForm {

    public function __construct($parent, $name) {
        parent::__construct($parent, $name);

        $this->addGroup();

        $courses = $this->addContainer('courses');

        $coursePages = $this->getCoursePages();
        $activeCourseId = $parent->getCourseId();

        $courseData = array();

        foreach ($coursePages as $coursePage) {
            $_name = $coursePage->_tree_node_id;
            $courses->addCheckbox($_name, $coursePage->_title);

            if ($coursePage->_tree_node_id == $activeCourseId) {
                 $this['courses-'.$_name]->setDefaultValue(TRUE);
            }

            $courseData[] = array(
                'id' => $_name,
                'title' => $coursePage->_name,
            );

            $this['courses-'.$_name]->getLabelPrototype()->class = 'css-label';
            $this['courses-'.$_name]->getControlPrototype()->class = 'css-checkbox';
        }

        $this->addText('name', 'Jméno')
            ->setRequired()
            ->addRule(Form::MAX_LENGTH, NULL, 100);


        $this->addText('address', 'Adresa')
            ->setRequired()
            ->addRule(Form::MAX_LENGTH, NULL, 100);

        $this->addText('email', 'Email')
            ->setRequired()
            ->addRule(Form::EMAIL)
            ->addRule(Form::MAX_LENGTH, NULL, 100);

        $this->addText('zip', 'PSČ')
            ->addRule(Form::MIN_LENGTH, NULL, 5)
            ->addRule(Form::MAX_LENGTH, NULL, 5);

        $this->addTextArea('message', 'Poznámka')
            ->addRule(Form::MAX_LENGTH, NULL, 500);

        $this->addCheckbox('is_company', 'Firma');

        $this->addText('ic', 'IČ')
            ->addConditionOn($this['is_company'], Form::EQUAL, 1)
            ->addRule(Form::FILLED)
            ->addRule(Form::MAX_LENGTH, NULL, 20);

        $this->addText('company', 'Jméno firmy')
            ->addConditionOn($this['is_company'], Form::EQUAL, 1)
            ->addRule(Form::FILLED)
            ->addRule(Form::MAX_LENGTH, NULL, 50);

        $this->addText('company_address', 'Adresa firmy')
            ->addConditionOn($this['is_company'], Form::EQUAL, 1)
            ->addRule(Form::FILLED)
            ->addRule(Form::MAX_LENGTH, NULL, 100);

        $this->addHidden('data', json_encode($courseData));

        $this['is_company']->getLabelPrototype()->class = 'css-label';
        $this['is_company']->getControlPrototype()->class = 'css-checkbox';

        $this->addSubmit('send','Odeslat');
        $this->onSuccess[] = array($this, 'formSubmited');
    }


    protected function getCoursePages() {
        $label = $this->presenter->pageManagerService->getLabelByName('Kurzy');
        $labelId = $label['label_id'];
        $lang = $this->presenter->getFullLang();
        $labelRoots = $this->presenter->pageManagerService->getLabelRoots($labelId, $lang);

        $labelRoot = reset($labelRoots);


        $allParams = array(
                        'labelId'               =>  $labelId,
                        'lang'                  =>  $lang,
                        'states'                =>  'published',
        );

        return $labelRoot->getDescendants($allParams);
    }

    protected function prepareCourseTitles($data) {
        $courseTitles = array();
        $_data = json_decode($data);
        foreach ($_data as $course) {
            $courseTitles[$course->id] = $course->title;
        }
        return $courseTitles;
    }


    public function formSubmited($form) {
        $formValues = $form->getValues();

        // send email to admin
        $emailTemplate = $this->initEmailTemplate(__DIR__.'/emailTemplates/buy.latte');
        $emailTemplate->values = $formValues;

        $emailTemplate->courseTitles = $this->prepareCourseTitles($formValues['data']);

        $this->sendEmail($emailTemplate, array(
            'from'  =>  "noreply@nauctesefotografovat.cz",
            'subject' => "Objednávka kurzu na nauctesefotografovat.cz",
            'to' => array(
                'jurasm2@gmail.com',
            ),
        ));

        // send email to client
        $clientEmailTemplate = $this->initEmailTemplate(__DIR__.'/emailTemplates/buy_to_client.latte');
        $this->sendEmail($clientEmailTemplate, array(
            'from'  =>  "noreply@nauctesefotografovat.cz",
            'subject' => "Objednávka kurzu na nauctesefotografovat.cz",
            'to' => array(
                $formValues['email'],
            ),
        ));


        $this->presenter->flashMessage('Formulář byl úspěšně odeslán.');
        $this->presenter->redirect('this');
    }

}
