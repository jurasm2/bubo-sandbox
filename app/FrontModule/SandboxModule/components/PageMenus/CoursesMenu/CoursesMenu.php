<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use FrontModule\SandboxModule\Components\Popup;

use Bubo;

use Nette\Utils\Html;

class CoursesMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Kurzy')->disableCaching();
    }


//    public function setUpRenderer($renderer) {
//        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');
//        $newWrappers = array(
//                        'topLevel'      =>  NULL,
//                        'topLevelItem'  =>  NULL,
//                        'innerLevel'      =>  NULL,
//                        'innerLevelItem'  =>  NULL
//        );
//
//        $renderer->setWrappers($newWrappers);
//        return $renderer;
//    }

    public function getTraverser() {
        /* @var $traverser Bubo\Traversing\RenderingTraversers\LabelTraverser */
        $traverser = $this->createLabelTraverser();
        return $traverser->skipFirst();
    }

//    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {
//
////        $loadPageParams = array(
////            'treeNodeId' => null,
////            'lang' => 'cs',
////        );
////        dump($this->presenter->pageManagerService->getPage($loadPageParams));
////        die();
//
//        $template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');
//
//        $template->page = $page;
//        $template->presenter = $this->presenter;
//
//        $menuItemContainer->add(Html::el()
//                            ->setHtml($template->__toString())
//                            );
//
//        return $menuItemContainer;
//
//    }

}