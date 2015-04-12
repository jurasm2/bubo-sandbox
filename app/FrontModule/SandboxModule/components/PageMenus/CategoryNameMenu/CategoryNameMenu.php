<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;
use Nette\Utils\Html;

class CategoryNameMenu extends Bubo\Navigation\PageMenu
{

	public function __construct($parent, $name, $lang)
	{
		parent::__construct($parent, $name, $lang);
		$this->setLabelName('Include in menu')->disableCaching();
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
			->setGoThroughActive();
		return $traverser;
	}

	public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight)
	{
		$template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');
		$template->page = $page;

		$menuItemContainer->add(Html::el()
			->setHtml($template->__toString())
		);
		return $menuItemContainer;
	}

}