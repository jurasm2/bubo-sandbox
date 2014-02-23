<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html,
    Bubo;

class HomepageImageMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Obrázkové menu na HP');
    }

    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');

        $newWrappers = array(
                        'topLevel'      =>  null,
                        'topLevelItem'  =>  'div',
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
                    ->limit(3);
    }

    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {

        if ($highlight) {
            $menuItemContainer->class .= 'active';
        }

        $menuItemContainer->class .= ' box-item img-container';
        
        $template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');

        $template->page = $page;

        if ($horizontalLevel == 3) {
            $menuItemContainer->class .= ' last';
        }

        $menuItemContainer->add(Html::el()
                            ->setHtml($template->__toString())
                            );

        return $menuItemContainer;

    }

}