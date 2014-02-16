<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;

use Nette\Utils\Html;

class TopMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Horní menu');
    }

    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');
        $renderer->getInnerLevelPrototype()->class = 'dropdown';
        return $renderer;
    }

    // return configured traverser
    public function getTraverser() {
        /* @var $traverser \Bubo\Traversing\RenderingTraversers\LabelTraverser */
        $traverser = $this->createLabelTraverser();
        return $traverser->highlight(true);
    }

    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {

        /* @var $page \Bubo\Pages\CMSPage */
        $label = $page->presenter->pageManagerService->getLabelByName('Tipy na výlety');
        $isLabelled = $label ? $page->isLabelledBy($label['label_id']) : false;

        return $menuItemContainer->add(Html::el('a')
                                        ->href($page->_front_url)
                                        ->title($page->_link_title)
                                        ->setText($page->_title)
                                        ->addClass($isLabelled ? 'non-clickable' : null));
    }

}