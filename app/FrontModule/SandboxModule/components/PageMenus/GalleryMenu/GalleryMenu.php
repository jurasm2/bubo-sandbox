<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html,
    Bubo;

class GalleryMenu extends Bubo\Navigation\PageMenu
{

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Galerie')->disableCaching();
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
                    ->skipFirst();
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

	    \Tracy\Debugger::barDump($page);


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