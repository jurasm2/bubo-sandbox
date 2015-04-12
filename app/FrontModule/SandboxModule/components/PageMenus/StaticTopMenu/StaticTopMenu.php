<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;

class StaticTopMenu extends Bubo\Navigation\PageMenu
{

	public function __construct($parent, $name, $lang)
	{
		parent::__construct($parent, $name, $lang);
		$this->setLabelName('Static menu')->disableCaching();
	}

	public function setUpRenderer($renderer)
	{
		$renderer->onRenderMenuItem = callback($this, 'renderMenuItem');
		// reset wrappers
		$newWrappers = [
			'topLevel'      =>  null,
			'topLevelItem'  =>  null,
			'innerLevel'      =>  null,
			'innerLevelItem'  =>  null
		];
		$renderer->setWrappers($newWrappers);
		return $renderer;
	}

	// return configured traverser
	public function getTraverser()
	{
		$traverser = $this->createLabelTraverser()
			->highlight();
		return $traverser;
	}

}