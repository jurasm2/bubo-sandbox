<?php

namespace FrontModule\SandboxModule\Components\Galleries;

class SliderGallery extends \FrontModule\Components\Galleries\DefaultGallery {

    public function setTemplateFile() {
        $this->templateFile = __DIR__ . '/templates/default.latte';
    }

}
