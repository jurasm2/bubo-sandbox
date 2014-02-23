<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html,
    Bubo;

class ReferenceMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Reference');
    }

    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');

        $newWrappers = array(
                        'topLevel'      =>  null,
                        'topLevelItem'  =>  null,
                        'innerLevel'      =>  null,
                        'innerLevelItem'      =>  null
        );

        $renderer->setWrappers($newWrappers);
        return $renderer;
    }

    // return configured traverser
    public function getTraverser() {
        /* @var $traverser \Bubo\Traversing\RenderingTraversers\LabelTraverser */
        $traverser = $this->createLabelTraverser();
        return $traverser
                    ->setEntity('page')
                    ->skipFirst()
                    ->limit(18);
    }

    public function renderMenuItem(
        $page,
        $acceptedStates,
        $menuItemContainer,
        $level,
        $horizontalLevel,
        $highlight,
        $numOfDescendants
    ) {

        $template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');

        $template->page = $page;
        $template->level = $horizontalLevel;
        $template->numOfItems = $numOfDescendants;

//        if ($horizontalLevel == 3) {
//            $menuItemContainer->class .= ' last';
//        }

        $menuItemContainer->add(Html::el()
                            ->setHtml($template->__toString())
                            );

        return $menuItemContainer;

    }

}