<?php

namespace BuboApp\AdminModule\Components;

use Bubo\Application\UI\Control;
use Nette\InvalidStateException;

/**
 * Class AdminMenu
 * @package BuboApp\AdminModule\Components
 */
class AdminMenu extends Control
{

	/**
	 * Registered admin menu sections
	 * @var array
	 */
	public $sections = array();

	/**
	 * Registers section
	 * @param int $sectionId
	 * @param null|int $index
	 */
	public function registerSection($sectionId, $index = NULL)
	{

		if ($sectionId !== NULL) {

			if (in_array($sectionId, $this->sections)) {
				throw new InvalidStateException("Section $sectionId is already registered in admin menu");
			}

			if ($index === NULL) {
				$this->sections[] = $sectionId;
			} else {
				if (!isset($this->sections[$index])) {
					$this->sections[$index] = $sectionId;
				} else {
					throw new InvalidStateException("Index $index in admin menu is already reserved");
				}
			}

		}
	}

	public function createComponent($name)
	{
		if (preg_match('([a-zA-Z0-9]+Section)', $name)) {
			// detect section
			$classname = "AdminMenu\\Sections\\" . ucfirst($name);
			if (class_exists($classname)) {
				$section = new $classname($this, $name);
				//$section->setTranslator($this->presenter->context->translator);
				return $section;
			}
		}

		return parent::createComponent($name);
	}

	public function render()
	{
		$template = parent::initTemplate(dirname(__FILE__) . '/adminMenu.latte');
		$template->sections = $this->sections;
		$template->render();
	}


}
