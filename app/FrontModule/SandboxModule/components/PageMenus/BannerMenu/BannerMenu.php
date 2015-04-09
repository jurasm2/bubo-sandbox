<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html;
use Bubo;
use Bubo\Navigation\PageMenu;

class BannerMenu extends PageMenu
{

    public function __construct($parent, $name, $lang)
    {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Banner')->disableCaching();
    }
    
    public function setUpRenderer($renderer)
    {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');
        
        $newWrappers = [
	        'topLevel' =>  null,
	        'topLevelItem' => null,
	        'innerLevel' => null,
	        'innerLevelItem' => null,
        ];

        $renderer->setWrappers($newWrappers);
        
        $renderer->getTopLevelPrototype()->class = 'news-box-row';
        $renderer->getTopLevelItemPrototype()->class = 'news-box fleft';
        
        return $renderer;
    }
    
    // return configured traverser
    public function getTraverser() {
        $traverser = $this->createLabelTraverser();
        return $traverser
	                ->setEntity('scrap')
                    ->limit(1);
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