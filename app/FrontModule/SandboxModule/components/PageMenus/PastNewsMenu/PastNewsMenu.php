<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;


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

}