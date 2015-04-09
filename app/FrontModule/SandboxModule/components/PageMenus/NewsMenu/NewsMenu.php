<?php

namespace FrontModule\SandboxModule\Components\PageMenus;

use Nette\Utils\Html,
    Bubo;

class NewsMenu extends Bubo\Navigation\PageMenu {
    
    public function __construct($parent, $name, $lang) {
        parent::__construct($parent, $name, $lang);
        $this->setLabelName('Novinky')->disableCaching();
    }
    
    public function setUpRenderer($renderer) {
        $renderer->onRenderMenuItem = callback($this, 'renderMenuItem');

        $newWrappers = [
            'topLevel'      =>  null,
            'topLevelItem'  =>  null,
            'innerLevel'      =>  null,
            'innerLevelItem'      =>  null,
        ];

        $renderer->setWrappers($newWrappers);

        $renderer->getTopLevelPrototype()->class = 'news-box-row';
        $renderer->getTopLevelItemPrototype()->class = 'news-box fleft';

        return $renderer;
    }
    
    // return configured traverser
    public function getTraverser()
    {
        $traverser = $this->createLabelTraverser();
        return $traverser
	                ->setEntity('scrap')
                    ->setSortingCallback(callback($this, 'customSort'))
	                ->setFilterCallback(callback($this, 'customFilter'))
                    ->limit(3)
                    ->skipFirst();
    }

	/**
	 * Bigger timestamp first
	 * @param $page1
	 * @param $page2
	 * @return int
	 */
    public function customSort($page1, $page2)
    {
        
        $date1 = \DateTime::createFromFormat('d.m.Y', $page1->_ext_news_date);
        $timestamp1 = $date1 ? $date1->getTimestamp() : 0;

        $date2 = \DateTime::createFromFormat('d.m.Y', $page2->_ext_news_date);
        $timestamp2 = $date2 ? $date2->getTimestamp() : 0;
        
        $sorting =  $timestamp2 - $timestamp1;
        
        return $sorting;
    }

	/**
	 * Take only comming news
	 * @param $page
	 * @return bool
	 */
	public function customFilter($page)
	{

		$date1 = \DateTime::createFromFormat('d.m.Y', $page->_ext_news_date);
		$timestamp1 = $page ? $date1->getTimestamp() : 0;

		$date2 = new \DateTime('midnight');
		$timestamp2 = $date2 ? $date2->getTimestamp() : 0;

		return $timestamp1 > $timestamp2;
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