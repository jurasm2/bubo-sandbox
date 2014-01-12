<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;
use Bubo\Utils\DateHelper;

use Nette\Utils\Html;

class ActionMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Akce')->disableCaching();
    }

    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');

        $newWrappers = array(
                        'topLevel'      =>  NULL,
                        'topLevelItem'  =>  NULL,
                        'innerLevel'      =>  NULL,
                        'innerLevelItem'      =>  NULL,
        );

        $renderer->setWrappers($newWrappers);

//        $renderer->getTopLevelPrototype()->class = 'news-box-row';
//        $renderer->getTopLevelItemPrototype()->class = 'news-box fleft';

        return $renderer;
    }

    // return configured traverser
    public function getTraverser() {
        $traverser = $this->createLabelTraverser();
        return $traverser
                    ->skipFirst()
                    ->limit(5)
                    ->setSortingCallback(callback($this, 'customSort'))
                    ->setFilterCallback(callback($this, 'customFilter'));
    }

    public function decorate($html) {
        $output = "";

        if ($html->__toString() != "") {
            $el = Html::el('div');
            $el->class = 'calendar-container';

            $label = $this->presenter->pageManagerService->getLabelByName('Termíny');
            $labelRoots = $this->presenter->pageManagerService->getLabelRoots($label['label_id'], 'cs');
            $root = reset($labelRoots);

            $a = Html::el(null);
            if ($root) {
                $a = Html::el('a')->href($root->_front_url);
            }
            $a->setText($this->presenter->getTranslator()->translate('Kalendář akcí'));
            $h3 = Html::el('h3');
            $caption = $h3->add($a);
            $el->add($caption);
            $output = $el->add($html);
        }
        return $output;
    }

    public function customSort($page1, $page2) {
        $date1 = DateHelper::createDate($page1->_ext_action_date, $page1->_ext_action_time);
        $timestamp1 = $date1 ? $date1->getTimestamp() : 0;

        $date2 = DateHelper::createDate($page2->_ext_action_date, $page2->_ext_action_time);
        $timestamp2 = $date2 ? $date2->getTimestamp() : 0;
        $sorting =  $timestamp2 - $timestamp1;

        return -$sorting;
    }

    public function customFilter($page) {
        $date = DateHelper::createDate($page->_ext_action_date, $page->_ext_action_time);
        if ($date !== FALSE) {
            return $date->getTimestamp() >= mktime(0, 0, 0);
        }
        return TRUE;
    }

    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {

        $template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');

        $template->page = $page;
        $template->presenter = $this->presenter;

        $menuItemContainer->add(Html::el()
                            ->setHtml($template->__toString())
                            );

        return $menuItemContainer;

    }

}