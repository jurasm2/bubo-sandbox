<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;

class TopMenu extends Bubo\Navigation\PageMenu {

    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Hlavní menu');

    }

    public function setUpRenderer($renderer) {
        $renderer->getTopLevelPrototype()->class = 'menu clearfix';
        return $renderer;
    }

    public function getTraverser() {
        /* @var $traverser Bubo\Traversing\RenderingTraversers\LabelTraverser */
        $traverser = $this->createLabelTraverser();
        return $traverser->highlight(TRUE);
    }
}