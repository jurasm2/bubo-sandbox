<?php

namespace BuboApp;

use Nette;
use	Nette\Application\Routers\RouteList;
use	Nette\Application\Routers\Route;
use Nette\Application\Routers\CliRouter;


/**
 * Router factory.
 */
class RouterFactory
{

	private $container;

	public function __construct(Nette\DI\Container $container) {
		$this->container = $container;
	}

	/**
	 * @return \Nette\Application\IRouter
	 */
	public function createRouter()
	{

		$dashedCamel = array(
			Route::FILTER_IN => array('Helpers\Inflectors', 'dash2camel'),
			Route::FILTER_OUT => array('Helpers\Inflectors', 'camel2dash')
		);

		$router = new RouteList;
		$router[] = new Route('index.php', 'Admin:Default:default', Route::ONE_WAY);

		// CRON ROUTES
		$router[] = $cronRouter = new RouteList('Cron');
		$cronRouter[] = new Route('cron', 'Cron:default');


		// ADMIN ROUTES
		$router[] = $adminRouter = new RouteList('Admin');

//		routes for plugins  -  obsolete
//		$adminRouter[] = new Route("[<lang [a-z]{2}>/]admin/plugin-interpreter/<plugin>/<view>",
//			array(
//				'presenter'  =>  'Plugin',
//				'action'     =>  'interpret',
//				'plugin'     =>  $dashedCamel,
//				'view'       =>  $dashedCamel
//			)
//		);

		$adminRouter[] = new Route("admin/copy-layout", 'Default:copyLayout');
		$adminRouter[] = new Route("admin/remove-pages", 'Default:removePages');
		$adminRouter[] = new Route("admin/repair-urls", 'Default:repairUrls');

		$adminRouter[] = new Route("show-draft/<url>", array(

				'presenter' =>  'Default',
				'action'    =>  'showDraft',
				'url'       =>  array(
					Route::FILTER_OUT => NULL
				)
			)
		);


		$adminRouter[] = new Route("[<lang [a-z]{2}>/]admin/<presenter>/<action>[/<id>]","Default:default");



		$router[] = $frontRouter = new RouteList('Front');



		$frontRouter[] = new Route("file/<url>",array(
			'presenter'=>'Image',
			'action'=>'default'
		));
		$frontRouter[] = new Route("file/<action>",array(
			'presenter'=>'Image',
			'action'=>'default'
		));
		$frontRouter[] = new Route("thumb/<name>",array(
			'presenter'=>'Image',
			'action'=>'thumbnail',
			'filename'=>array(Route::FILTER_OUT => NULL),
			'name'=>NULL,
			'lang'=>NULL
		));

		// TEST
		$selectedModuleNs = 'Front/Sandbox';
		$selectedHost = 'localhost/bubo-sandbox/www/';

		$selectedModule = $selectedModuleNs;
		// make from ns module name
		$slashPos = strrpos($selectedModuleNs, '/', -1);
		if ($slashPos !== FALSE) {
			$selectedModule = substr($selectedModuleNs, $slashPos+1);
		}

		$m = explode('/', $selectedModuleNs);
		array_shift($m);


		if ($selectedModuleNs !== NULL) {

			$frontRouter[] = new Route("//".$selectedHost."[<lang [a-z]{2}>/][<url>]", array(
				//'module'    =>  $selectedModule,
				'module'    =>  implode(':', $m),
				'presenter' =>  'Default',
				'action'    =>  'default',
				'url'       =>  array(
					Route::FILTER_OUT => NULL,
					Route::PATTERN => ".*"
				)
			));

		}




//
//		$router = new RouteList();
//		if ($this->container->parameters['consoleMode']) {
//			$router[] = new CliRouter(array('action' => 'Cli:default'));
//		} else {
//			$router[] = new Route('<presenter>/<action>[/<id>]', 'Default:default');
//		}
		return $router;
	}

}
