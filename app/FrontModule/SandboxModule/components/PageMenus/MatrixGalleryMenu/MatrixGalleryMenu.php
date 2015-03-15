<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;
use Nette\Utils\Html;

class MatrixGalleryMenu extends Bubo\Navigation\PageMenu
{

	public function __construct($parent, $name, $lang)
	{
		parent::__construct($parent, $name, $lang);
		$this->setLabelName('Matrix gallery')->disableCaching();
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
		$traverser = $this->createLabelTraverser()->setEntity('page');
		return $traverser;
	}


	public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight)
	{
		if ($highlight) {
			$menuItemContainer->class .= 'active';
		}

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