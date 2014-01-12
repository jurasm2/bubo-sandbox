<?php

namespace FrontModule\SandboxModule\Components;

use Bubo\Application\UI\Control;

/**
 *
 */
class PriceTicket extends Control {

    public function currency($s) {
        return $s == '' ?
                    "" :
                    sprintf('%s Kč', number_format($s, 0, ',', ' '));
    }

    protected function _createTemplate($templateFile) {
        $template = $this->initTemplate($templateFile);
        $template->registerHelper('currency', callback($this, 'currency'));
        return $template;
    }

    /**
     * Rendering method
     */
    public function render($page) {
        $template = $this->_createTemplate(__DIR__ . '/templates/default.latte');
        $template->page = $page;
        $template->isSmall = FALSE;
        echo $template;
    }

    /**
     * Rendering method
     */
    public function renderSmall($page) {
        $template = $this->_createTemplate(__DIR__ . '/templates/default.latte');
        $template->page = $page;
        $template->isSmall = TRUE;
        echo $template;
    }

}

