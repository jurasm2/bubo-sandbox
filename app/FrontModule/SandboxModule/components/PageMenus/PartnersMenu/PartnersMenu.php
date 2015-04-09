<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html,
    Bubo;

class PartnersMenu extends Bubo\Navigation\PageMenu
{
    
    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Partneři')->disableCaching();
    }
    
    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');

        $newWrappers = [
            'topLevel'      =>  'dl',
            'topLevelItem'  =>  null,
            'innerLevel'      =>  null,
            'innerLevelItem'      =>  null,
        ];

        $renderer->setWrappers($newWrappers);

        return $renderer;
    }
    
    // return configured traverser
    public function getTraverser()
    {
        $traverser = $this->createLabelTraverser();
        return $traverser
	                ->setEntity('scrap')
                    ->skipFirst();
    }

    public function renderMenuItem($page, $acceptedStates, $menuItemContainer, $level, $horizontalLevel, $highlight) {

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