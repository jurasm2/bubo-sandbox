<?php

namespace FrontModule\SandboxModule\Components\Galleries;

use FrontModule\Components\Galleries\DefaultGallery;

class SwiperGallery extends DefaultGallery
{

	public function setTemplateFile()
	{
		$this->templateFile = __DIR__ . '/templates/default.latte';
	}

}
