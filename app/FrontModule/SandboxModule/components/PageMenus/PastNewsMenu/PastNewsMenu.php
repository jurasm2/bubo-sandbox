<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;
use Nette\Utils\Html;


class PastNewsMenu extends NewsMenu
{
	/**
	 * Take only past news
	 * @param $page
	 * @return bool
	 */
	public function customFilter($page)
	{
		return !parent::customFilter($page);
	}

	public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {

		if ($highlight) {
			$menuItemContainer->class .= ' active';
		}

		$template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');

		$template->page = $page;
		$template->isLast = $horizontalLevel == 3;

		if ($horizontalLevel == 3) {
			$menuItemContainer->class .= ' last';
		}

		$menuItemContainer->add(Html::el()
			->setHtml($template->__toString())
		);

		return $menuItemContainer;

	}
}