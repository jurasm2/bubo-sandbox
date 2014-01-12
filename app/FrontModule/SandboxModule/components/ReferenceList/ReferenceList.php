<?php

namespace FrontModule\SandboxModule\Components;

use Bubo\Application\UI\Control;

/**
 *
 */
class ReferencesList extends Control {

    /**
     * Rendering method
     */
    public function render($lang) {
        $template = $this->initTemplate(__DIR__ . '/templates/default.latte');
        $references = $this->presenter->context->modelLoader->loadModel('ReferencesModel')->getReferences($lang);
        $template->references = $references;
        echo $template;
    }

}

