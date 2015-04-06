<?php
/* version Virgin1 */

// Load Nette Framework
require LIBS_DIR . '/autoload.php';

$developedLibraries = [
	'/opt/lampp/htdocs/bubo',
	'/opt/lampp/htdocs/datagrid',
];

// Configure application
$configurator = new Nette\Configurator;

\Tracy\Debugger::$showLocation = true;

// Enable Nette Debugger for error visualisation & logging
$configurator->setDebugMode(TRUE);
$configurator->enableDebugger(__DIR__ . '/../log');

// Enable RobotLoader - this will load all classes automatically
$configurator->setTempDirectory(__DIR__ . '/../temp');
$robotLoader = $configurator->createRobotLoader()->addDirectory(APP_DIR);

if ($developedLibraries) {
	foreach ($developedLibraries as $libDirectory) {
		$robotLoader->addDirectory($libDirectory);
	}
}

$robotLoader->register();


//Extras\Debug\ComponentTreePanel::register();

// Create Dependency Injection container from config.neon file
$configurator->addConfig(CONFIG_DIR . '/config.neon');
//$configurator->addConfig(CONFIG_DIR . '/config2.neon');

$loader = new Nette\DI\Config\Adapters\NeonAdapter();
$serverName = $_SERVER['SERVER_NAME'];

$selectedModuleNs = NULL;
$selectedHost = NULL;
$selectedProjectPath = NULL;
$selectedFile = NULL;
// detect project
foreach (Nette\Utils\Finder::findDirectories('*Module')->in(APP_DIR.'/FrontModule') as $projectPath => $file) {
    // read project config
    $projectFile = $projectPath . '/config/project.neon';
    $configFile = $projectPath . '/config/config.neon';

    //dump($file->getBaseName());

    if (is_file($projectFile) && is_file($configFile)) {
        $c = $loader->load($projectFile);


        foreach ($c['modules'] as $moduleNs => $moduleData) {

            foreach ($moduleData['hosts'] as $host) {
                if (preg_match("#.*$serverName\/.*#", $host)) {
                    $selectedModuleNs = $moduleNs;
                    $selectedHost = $host;
                    $selectedProjectPath = $projectPath;
                    $selectedFile = $file;
                    break;
                }
            }

            if ($selectedModuleNs !== NULL) {
                $configurator->addConfig($configFile);
                break;
            }
        }

    }

    if ($selectedModuleNs !== NULL) break;


}

if ($selectedProjectPath === NULL) {
    throw new \Nette\InvalidStateException('The project does not exist!');
}

$params = array(
			'appModuleNamespace' => $selectedModuleNs,
			'appHost' => $selectedHost,
            'projectName'    => $selectedFile->getBaseName(),
            'projectDir'    =>  $selectedProjectPath
);
$configurator->addParameters($params);


$container = $configurator->createContainer();

$appDir = $container->parameters['appDir'];


//\Kdyby\Forms\Containers\Replicator::register();
\Bubo\Profiler\MenuProfiler\MenuProfiler::register();
//SimpleProfiler\Profiler::register();
//Extras\Debug\ComponentTreePanel::$dumps = FALSE;
//Extras\Debug\ComponentTreePanel::register();

//$container->application->catchExceptions = FALSE;
\dibi::setConnection($container->database);
\MultipleFileUpload\MultipleFileUpload::register();
\MultipleFileUpload\MultipleFileUpload::getUIRegistrator()
    ->clear()
    //->register('MultipleFileUpload\UI\HTML4SingleUpload');
    ->register('MultipleFileUpload\UI\Plupload');
////            ->register("MFUUISwfupload");
////            ->register("MFUUIUploadify");
//
//// Optional step: register driver
//// As default driver is used Sqlite driver
//// @see http://addons.nettephp.com/cs/multiplefileupload#toc-drivery
//// When you want to use other driver use something like this:
if(class_exists("Dibi", true)) {
    // dibi is already connected
    \MultipleFileUpload\MultipleFileUpload::setQueuesModel(new \MultipleFileUpload\Model\Dibi\Queues());
    \MultipleFileUpload\MultipleFileUpload::setLifeTime(3600); // 1hour for temporarily uploaded files
}

/**
 * Extension method for FormContainer
 */
function FormContainer_addMediaFile(/*\Nette\Application\UI\Form*/ $_this, $name, $label = NULL) {
  return $_this[$name] = new \Bubo\MediaFileInput($label);
//    echo "mediaFile je připojeny";
//    die();
}


\Nette\Forms\Container::extensionMethod("\Nette\Forms\Container::addMediaFile", "FormContainer_addMediaFile");


return $container;



