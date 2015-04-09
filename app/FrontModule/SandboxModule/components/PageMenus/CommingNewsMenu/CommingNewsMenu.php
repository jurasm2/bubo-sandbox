<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Bubo;

class CommingNewsMenu extends NewsMenu
{

	public function customSort($page1, $page2)
	{
		return -parent::customSort($page1, $page2);
	}

}