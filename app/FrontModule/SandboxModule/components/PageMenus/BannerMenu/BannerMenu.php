<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;

use Nette\Utils\Html;

class BannerMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Banner')->disableCaching();
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
        return $traverser->skipFirst();
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