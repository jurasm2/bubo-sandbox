<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use FrontModule\SandboxModule\Components\Popup;

use Bubo;
use Bubo\Utils\DateHelper;

use Nette\Utils\Html;

class TermsMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Termíny')->disableCaching();

    }

    public function createComponentAssignPopup($name) {
        return new Popup($this, $name, Popup::ASSIGN);
    }

    public function createComponentBuyPopup($name) {
        return new Popup($this, $name, Popup::BUY);
    }

    public function handleLogToTerm($termData) {
        echo $this['assignPopup']
            ->setTermData($termData)
            ->render();
        die();
    }

    public function handleBuyTerm($courseId) {
        $this['buyPopup']->setCourseId($courseId);
        echo $this['buyPopup']->render($courseId);
        die();
    }

    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');
        $newWrappers = array(
                        'topLevel'      =>  NULL,
                        'topLevelItem'  =>  NULL,
                        'innerLevel'      =>  NULL,
                        'innerLevelItem'  =>  NULL
        );

        $renderer->setWrappers($newWrappers);
        return $renderer;
    }


    public function customSort($page1, $page2) {
        $date1 = DateHelper::createDate($page1->_ext_course_date, $page1->_ext_course_time);
        $timestamp1 = $date1 ? $date1->getTimestamp() : 0;

        $date2 = DateHelper::createDate($page2->_ext_course_date, $page2->_ext_course_time);
        $timestamp2 = $date2 ? $date2->getTimestamp() : 0;
        $sorting =  $timestamp2 - $timestamp1;

        return -$sorting;
    }

    public function customFilter($page) {
        $date = DateHelper::createDate($page->_ext_course_date);
        if ($date !== FALSE) {
            return $date->getTimestamp() >= mktime(0, 0, 0);
        }
        return TRUE;
    }

    public function getTraverser() {
        /* @var $traverser Bubo\Traversing\RenderingTraversers\LabelTraverser */
        $traverser = $this->createLabelTraverser();
        return $traverser
                    ->skipFirst()
                    ->setSortingCallback(callback($this, 'customSort'))
                    ->setFilterCallback(callback($this, 'customFilter'));
    }

    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {

        $termDetail = array(
            'time' => $page->_ext_course_time,
            'date' => $page->_ext_course_date,
            'title' => null,
        );
        if ($page->_ext_course) {
            $termDetail['title'] = $page->_ext_course->_name;
        }

        $template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');

        $template->page = $page;
        $template->presenter = $this->presenter;
        $template->termDetail = json_encode($termDetail);


        $menuItemContainer->add(Html::el()
                            ->setHtml($template->__toString())
                            );

        return $menuItemContainer;

    }

}