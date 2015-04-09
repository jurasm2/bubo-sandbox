<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html;
use Bubo;
use Bubo\Navigation\PageMenu;

class RunningNewsMenu extends PageMenu
{
    
    public function __construct($parent, $name, $lang)
    {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Běžící novinka')->disableCaching();
    }
    
    public function setUpRenderer($renderer)
    {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');

//	    $newWrappers = [
//		    'topLevel' =>  null,
//		    'topLevelItem' => null,
//		    'innerLevel' => null,
//		    'innerLevelItem' => null,
//	    ];
//
//	    $renderer->setWrappers($newWrappers);
        return $renderer;
    }
    
    
    // return configured traverser
    public function getTraverser()
    {
        $traverser = $this->createLabelTraverser();
        return $traverser
	                ->setEntity('scrap');
    }
   
     
    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight)
    {

        if ($highlight) {
            $menuItemContainer->class .= 'active';
        }

        $template = $this->initTemplate(__DIR__ . '/templates/menuItem.latte');

        $template->page = $page;

	    $menuItemContainer->add(Html::el()
		    ->setHtml($template->__toString())
	    );

        return $menuItemContainer;

    }
    
}