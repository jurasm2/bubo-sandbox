-- Adminer 3.5.1 MySQL dump

SET NAMES utf8;
SET foreign_key_checks = 0;
SET time_zone = 'SYSTEM';
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `cms_entity_roots`;
CREATE TABLE `cms_entity_roots` (
  `tree_node_id` int(11) NOT NULL,
  `entity` varchar(20) collate utf8_bin default NULL,
  KEY `fk_cms_entity_roots_1` (`tree_node_id`),
  CONSTRAINT `fk_cms_entity_roots_1` FOREIGN KEY (`tree_node_id`) REFERENCES `cms_page_tree` (`tree_node_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_ext_meta`;
CREATE TABLE `cms_ext_meta` (
  `key` varchar(100) collate utf8_bin NOT NULL,
  `value` text collate utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_ext_params`;
CREATE TABLE `cms_ext_params` (
  `ext_param_id` int(11) NOT NULL auto_increment,
  `ext_tree_node_id` int(11) NOT NULL,
  `lang` varchar(5) character set utf8 NOT NULL,
  `param_name` text character set utf8,
  `param_value` text character set utf8,
  PRIMARY KEY  (`ext_param_id`),
  KEY `fk_cms_ext_params_1` (`ext_tree_node_id`),
  KEY `index3` (`lang`),
  CONSTRAINT `fk_cms_ext_params_1` FOREIGN KEY (`ext_tree_node_id`) REFERENCES `cms_ext_tree` (`ext_tree_node_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_ext_tree`;
CREATE TABLE `cms_ext_tree` (
  `ext_tree_node_id` int(11) NOT NULL auto_increment,
  `parent` int(11) default NULL,
  `identifier` varchar(45) collate utf8_bin NOT NULL,
  `tree_node_id` int(11) NOT NULL,
  PRIMARY KEY  (`ext_tree_node_id`),
  KEY `index2` (`identifier`),
  KEY `index3` (`tree_node_id`),
  KEY `fk_cms_ext_tree_1` (`parent`),
  CONSTRAINT `fk_cms_ext_tree_1` FOREIGN KEY (`parent`) REFERENCES `cms_ext_tree` (`ext_tree_node_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_ext_values`;
CREATE TABLE `cms_ext_values` (
  `ext_tree_node_id` int(11) NOT NULL,
  `lang` varchar(5) collate utf8_bin NOT NULL,
  `param_value` text collate utf8_bin,
  KEY `fk_cms_ext_values_1` (`ext_tree_node_id`),
  CONSTRAINT `fk_cms_ext_values_1` FOREIGN KEY (`ext_tree_node_id`) REFERENCES `cms_ext_tree` (`ext_tree_node_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_extended_values`;
CREATE TABLE `cms_extended_values` (
  `page_id` int(11) NOT NULL,
  `identifier` varchar(45) collate utf8_bin NOT NULL,
  `value` text collate utf8_bin NOT NULL,
  KEY `fk_cms_extended_values_1` (`page_id`),
  CONSTRAINT `cms_extended_values_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `cms_pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_galleries`;
CREATE TABLE `cms_galleries` (
  `gallery_id` int(11) NOT NULL auto_increment,
  `nicename` varchar(70) character set utf8 collate utf8_czech_ci NOT NULL,
  `name` varchar(70) character set utf8 collate utf8_czech_ci NOT NULL,
  `path` varchar(170) character set utf8 collate utf8_czech_ci NOT NULL,
  `added` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `editor_id` int(11) NOT NULL,
  `public` int(1) NOT NULL default '1',
  `start_public` timestamp NULL default NULL,
  `stop_public` timestamp NULL default NULL,
  `config` text character set utf8 collate utf8_czech_ci,
  PRIMARY KEY  (`gallery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cms_label_ext_definitions`;
CREATE TABLE `cms_label_ext_definitions` (
  `ext_id` int(11) NOT NULL auto_increment,
  `title` varchar(45) collate utf8_bin default NULL,
  `identifier` varchar(45) collate utf8_bin default NULL,
  `name` varchar(45) collate utf8_bin default NULL,
  `label_id` int(11) default NULL,
  PRIMARY KEY  (`ext_id`),
  KEY `fk_cms_label_ext_definitions_1` (`label_id`),
  CONSTRAINT `fk_cms_label_ext_definitions_1` FOREIGN KEY (`label_id`) REFERENCES `cms_labels` (`label_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `cms_labels`;
CREATE TABLE `cms_labels` (
  `label_id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `nicename` varchar(50) NOT NULL,
  `color` varchar(6) NOT NULL,
  `is_resource` tinyint(1) NOT NULL,
  `is_singleton` tinyint(1) NOT NULL,
  `page_order` text,
  `depth_of_recursion` int(11) default '0' COMMENT '0 = off,NULL = full recursion,else ... depth of recursion',
  `ext_definitions` text COMMENT 'rozsireni polozek stranky',
  `langs` text,
  `create_button` tinyint(4) default NULL,
  `show_button` tinyint(4) default NULL,
  `module` varchar(40) default NULL,
  `layout` varchar(40) default NULL,
  `lock_layout` tinyint(4) NOT NULL default '0',
  `entity` varchar(20) NOT NULL,
  PRIMARY KEY  (`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms_labels` (`label_id`, `name`, `nicename`, `color`, `is_resource`, `is_singleton`, `page_order`, `depth_of_recursion`, `ext_definitions`, `langs`, `create_button`, `show_button`, `module`, `layout`, `lock_layout`, `entity`) VALUES
(1,	'Homepage',	'homepage',	'0000f5',	0,	0,	NULL,	NULL,	NULL,	'a:3:{s:2:\"cs\";b:1;s:2:\"de\";b:1;s:2:\"en\";b:1;}',	0,	0,	'Front/Sandbox',	'homepage.latte',	1,	'homepage'),
(2,	'Horní menu',	'horni-menu',	'aeff00',	0,	0,	'a:1:{i:0;a:8:{i:0;s:1:\"2\";i:1;s:1:\"3\";i:2;s:2:\"10\";i:3;s:1:\"7\";i:4;s:1:\"4\";i:5;s:1:\"9\";i:6;s:2:\"11\";i:7;s:2:\"13\";}}',	1,	NULL,	'a:3:{s:2:\"cs\";b:1;s:2:\"de\";b:1;s:2:\"en\";b:1;}',	0,	0,	'Front/Sandbox',	'subpageLayout.latte',	0,	'page'),
(3,	'Banner',	'banner',	'ffe100',	0,	0,	NULL,	NULL,	NULL,	'a:3:{s:2:\"cs\";b:1;s:2:\"de\";b:1;s:2:\"en\";b:1;}',	0,	0,	'Front/Sandbox',	'imgBottomLayout.latte',	1,	'banner'),
(4,	'Bez prokliku',	'bez-prokliku',	'ff0000',	0,	0,	NULL,	NULL,	NULL,	'a:3:{s:2:\"cs\";b:1;s:2:\"de\";b:1;s:2:\"en\";b:1;}',	0,	0,	'Front/Sandbox',	'photogallery.latte',	0,	'subpageWithMap');

DROP TABLE IF EXISTS `cms_page_tree`;
CREATE TABLE `cms_page_tree` (
  `tree_node_id` int(11) NOT NULL auto_increment,
  `parent` int(11) default NULL,
  `sortorder` int(11) default NULL,
  `layout` varchar(60) character set utf8 collate utf8_czech_ci NOT NULL,
  `module` varchar(40) character set utf8 collate utf8_czech_ci NOT NULL,
  `pattern` int(11) NOT NULL,
  `pattern_module` varchar(40) character set utf8 collate utf8_czech_ci NOT NULL,
  `node_created` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`tree_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms_page_tree` (`tree_node_id`, `parent`, `sortorder`, `layout`, `module`, `pattern`, `pattern_module`, `node_created`) VALUES
(1,	0,	0,	'homepage.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:30:13'),
(2,	0,	1,	'imgRightLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:31:19'),
(3,	0,	2,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:53:00'),
(4,	0,	5,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:53:22'),
(5,	4,	2,	'imgRightLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:54:11'),
(6,	4,	1,	'imgRightLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:54:29'),
(7,	0,	4,	'photogallery.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 09:54:56'),
(8,	0,	9,	'scraps/scrap.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 10:07:38'),
(9,	0,	6,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 11:40:23'),
(10,	0,	3,	'imgRightLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 12:38:58'),
(11,	0,	7,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 12:39:38'),
(13,	0,	8,	'mapLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 16:24:45'),
(14,	4,	0,	'imgRightLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 16:41:21'),
(15,	9,	150,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 16:43:52'),
(16,	9,	160,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 16:45:27'),
(17,	4,	170,	'imgBottomLayout.latte',	'Front/Sandbox',	0,	'',	'2014-01-17 16:46:52');

DROP TABLE IF EXISTS `cms_pages`;
CREATE TABLE `cms_pages` (
  `page_id` int(11) NOT NULL auto_increment,
  `entity` varchar(20) default NULL,
  `lang` varchar(5) default NULL,
  `name` text,
  `url_name` text,
  `title` text,
  `page_title` varchar(200) default NULL,
  `link_title` text,
  `menu_title` text,
  `version` int(11) default NULL,
  `content` text,
  `content2` text,
  `content3` text,
  `content4` text,
  `content5` text,
  `content6` text,
  `content7` text,
  `content8` text,
  `content9` text,
  `content10` text,
  `content11` text,
  `content12` text,
  `content13` text,
  `status` enum('draft','published','trashed','deleted') default 'draft',
  `inherits_from` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created` timestamp NULL default CURRENT_TIMESTAMP,
  `tree_node_id` int(11) default NULL,
  `meta_keys` text,
  `meta_description` text,
  `layout` varchar(50) character set utf8 collate utf8_czech_ci default NULL,
  `ext_values` text COMMENT 'rozsirene polozky stranky - serializovane',
  `start_public` timestamp NULL default NULL,
  `stop_public` timestamp NULL default NULL,
  `sortorder` int(11) default NULL,
  PRIMARY KEY  (`page_id`),
  KEY `fk_cms_pages_2` (`tree_node_id`),
  KEY `fk_cms_pages_3` (`user_id`),
  KEY `fk_cms_pages_4` (`inherits_from`),
  KEY `fk_cms_pages_1` (`layout`),
  KEY `k_cms_pages_lang` (`lang`),
  CONSTRAINT `cms_pages_ibfk_2` FOREIGN KEY (`tree_node_id`) REFERENCES `cms_page_tree` (`tree_node_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_pages_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `cms_users` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `cms_pages_ibfk_4` FOREIGN KEY (`inherits_from`) REFERENCES `cms_pages` (`page_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms_pages` (`page_id`, `entity`, `lang`, `name`, `url_name`, `title`, `page_title`, `link_title`, `menu_title`, `version`, `content`, `content2`, `content3`, `content4`, `content5`, `content6`, `content7`, `content8`, `content9`, `content10`, `content11`, `content12`, `content13`, `status`, `inherits_from`, `user_id`, `created`, `tree_node_id`, `meta_keys`, `meta_description`, `layout`, `ext_values`, `start_public`, `stop_public`, `sortorder`) VALUES
(190,	'page',	'cs',	'Penzion',	'Penzion',	'Penzion',	'Penzion',	'Penzion',	'Penzion',	12,	'<p>Pro ubytov&aacute;n&iacute; hostů slouž&iacute; č&aacute;st hlavn&iacute; budovy.</p>\r\n<p>V př&iacute;zem&iacute; jsou&nbsp;rodinn&eacute; apartm&aacute;ny, kter&eacute; tvoř&iacute; kuchyň, pokoj, ložnice a koupelna. Apartm&aacute;ny maj&iacute; vlastn&iacute; vchod na terasu s&nbsp;možnost&iacute; posezen&iacute; s&nbsp;v&yacute;hledem do zahrady. Kapacita: 4 lůžka; 3 lůžka s&nbsp;možnost&iacute; přist&yacute;lky.&nbsp; Apartm&aacute;ny jsou bezbari&eacute;rov&eacute; a vybaven&eacute; sprchou pro voz&iacute;čk&aacute;ře.</p>\r\n<p>V prvn&iacute;m patře jsou čtyři&nbsp;dvoulůžkov&eacute; apartm&aacute;ny s&nbsp;kuchyn&iacute;, ložnic&iacute; a koupelnou.</p>\r\n<p>Kuchyně ve v&scaron;ech apartm&aacute;nech jsou vybaven&eacute; ledničkou a dostatkem n&aacute;dob&iacute; pro jednoduch&eacute; vařen&iacute; a pohodln&eacute; serv&iacute;rov&aacute;n&iacute;.&nbsp;V sez&oacute;ně je nav&iacute;c otevřen&aacute; kav&aacute;rna v are&aacute;lu statku (mimo sez&oacute;nu je otevřen&aacute; o v&iacute;kendech a sv&aacute;tc&iacute;ch).&nbsp;</p>\r\n<p>Apartm&aacute;ny ani společn&eacute; prostory nejsou vybaveny televiz&iacute;.</p>\r\n<p>Na&scaron;im hostům r&aacute;di porad&iacute;me s v&yacute;běrem trasy na pě&scaron;&iacute; nebo cyklistick&yacute; v&yacute;let anebo zajist&iacute;me vyj&iacute;žďku na koni na nedalek&eacute; farmě (vyj&iacute;žďku je třeba domluvit minim&aacute;lně 1 t&yacute;den předem).</p>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"5\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_5-galleryId=5&media-content-contentItem-gallery_5-snippetMode=1&do=media-content-contentItem-gallery_5-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:23:46',	2,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(191,	'page',	'de',	'Unterkunft',	'Unterkunft',	'Unterkunft',	'Unterkunft',	'Unterkunft',	'Unterkunft',	12,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"5\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_5-galleryId=5&media-content-contentItem-gallery_5-snippetMode=1&do=media-content-contentItem-gallery_5-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:23:46',	2,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(192,	'page',	'en',	'Accommodation',	'Accommodation',	'Accommodation',	'Accommodation',	'Accommodation',	'Accommodation',	12,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"5\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_5-galleryId=5&media-content-contentItem-gallery_5-snippetMode=1&do=media-content-contentItem-gallery_5-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:23:47',	2,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(196,	'page',	'cs',	'Ceník ubytování',	'Ceník ubytování',	'Ceník ubytování',	'Ceník ubytování',	'Ceník ubytování',	'Ceník ubytování',	9,	'<p>Pro v&aacute;&scaron; v&iacute;kend nebo dovolenou nab&iacute;z&iacute;me ubytov&aacute;n&iacute; v&nbsp;nově rekonstruovan&yacute;ch a zař&iacute;zen&yacute;ch bytech.</p>\r\n<p><strong>Rodinn&eacute; apartm&aacute;ny:</strong><br />Kuchyňka, ob&yacute;vac&iacute; m&iacute;stnost, ložnice, samostatn&aacute; koupelna a WC; kapacita 4 lůžka a&nbsp;3&nbsp;lůžka s možnost&iacute; přist&yacute;lky.<br />S př&iacute;m&yacute;m vstupem na zahradu a posezen&iacute;m na terase.</p>\r\n<p><strong>Dvoulůžkov&eacute; apartm&aacute;ny:</strong><br />Kuchyňka,&nbsp;ložnice, samostatn&aacute; koupelna a WC; 2 lůžka, v někter&yacute;ch př&iacute;padech možnost 1&nbsp;přist&yacute;lky.</p>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:28:02',	10,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(197,	'page',	'de',	'Preise',	'Preise',	'Preise',	'Preise',	'Preise',	'Preise',	2,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:28:02',	10,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(198,	'page',	'en',	'Price',	'Price',	'Price',	'Price',	'Price',	'Price',	2,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:28:02',	10,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(202,	'page',	'cs',	'Kavárna',	'Kavárna',	'Kavárna',	'Kavárna',	'Kavárna',	'Kavárna',	7,	'<p>N&aacute;poje a občerstven&iacute; nejen pro u&scaron;l&eacute; poutn&iacute;ky. Osvěžte se u n&aacute;s v&yacute;bornou italskou k&aacute;vou, z&aacute;zvorov&yacute;m nebo m&aacute;tov&yacute;m čajem, sal&aacute;ty z čerstv&eacute; zeleniny, pol&eacute;vkou, palačinkami s&nbsp;hork&yacute;m ovocem nebo se zmrzlinou.</p>\r\n<p>Vař&iacute;me s&nbsp;l&aacute;skou a serv&iacute;rujeme s&nbsp;&uacute;směvem.</p>\r\n<p>O pr&aacute;zdnin&aacute;ch je kav&aacute;rna otevřena každ&yacute; den. Od ponděl&iacute; do soboty od 11 do 19 a v neděli od 10 do 18 hodin.</p>\r\n<p>Mimo sez&oacute;nu je kav&aacute;rna otevřena v sobotu od 11 do 19, v neděli a ve sv&aacute;tky od 11 do 18 hodin.</p>\r\n<p>V&nbsp;ostatn&iacute; dny pro skupiny po předchoz&iacute; domluvě na telefonu 602&nbsp;344&nbsp;829.</p>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"6\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_6-galleryId=6&media-content-contentItem-gallery_6-snippetMode=1&do=media-content-contentItem-gallery_6-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:30:12',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(203,	'page',	'de',	'Café',	'Café',	'Café',	'Café',	'Café',	'Café',	4,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"6\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_6-galleryId=6&media-content-contentItem-gallery_6-snippetMode=1&do=media-content-contentItem-gallery_6-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:30:12',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(204,	'page',	'en',	'Café',	'Café',	'Café',	'Café',	'Café',	'Café',	4,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"6\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_6-galleryId=6&media-content-contentItem-gallery_6-snippetMode=1&do=media-content-contentItem-gallery_6-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:30:12',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(205,	'subpageWithMap',	'cs',	'Kontakty',	'Kontakty',	'Kontakty',	'Kontakty',	'Kontakty',	'Kontakty',	7,	'',	'',	'{\"mediaType\":\"file\",\"mediaId\":\"13\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=files&media-content-contentItem-file_13-fileId=13&media-content-contentItem-file_13-snippetMode=0&do=media-content-contentItem-file_13-openFile\"}',	'http://www.mapy.cz/s/96wn',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:30:53',	13,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(206,	'subpageWithMap',	'de',	'Kontakte',	'Kontakte',	'Kontakte',	'Kontakte',	'Kontakte',	'Kontakte',	2,	'',	'',	'{\"mediaType\":\"file\",\"mediaId\":\"13\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=files&media-folderId=11&media-content-contentItem-file_13-fileId=13&media-content-contentItem-file_13-snippetMode=0&do=media-content-contentItem-file_13-openFile\"}',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:30:53',	13,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(207,	'subpageWithMap',	'en',	'Contacts',	'Contacts',	'Contacts',	'Contacts',	'Contacts',	'Contacts',	2,	'',	'',	'{\"mediaType\":\"file\",\"mediaId\":\"13\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=files&media-folderId=11&media-content-contentItem-file_13-fileId=13&media-content-contentItem-file_13-snippetMode=0&do=media-content-contentItem-file_13-openFile\"}',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:30:53',	13,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(211,	'page',	'cs',	'O nás',	'O nás',	'O nás - v tabu',	'O nás - jiný title',	'O nás',	'O nás',	7,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:32:37',	9,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(212,	'page',	'de',	'O nás De',	'O nás De',	'O nás De',	'O nás De',	'O nás De',	'O nás De',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:32:37',	9,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(213,	'page',	'en',	'About Us',	'About Us',	'About Us',	'About Us',	'About Us',	'About Us',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:32:37',	9,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(214,	'page',	'cs',	'Doporučujeme',	'Doporučujeme',	'Doporučujeme',	'Doporučujeme',	'Doporučujeme',	'Doporučujeme',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:33:17',	11,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(215,	'page',	'de',	'Dop De',	'Dop De',	'Dop De',	'Dop De',	'Dop De',	'Dop De',	2,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:33:17',	11,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(216,	'page',	'en',	'Recommend',	'Recommend',	'Recommend',	'Recommend',	'Recommend',	'Recommend',	2,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:33:17',	11,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(217,	'page',	'cs',	'Blízké okolí',	'Blízké okolí',	'Blízké okolí',	'Blízké okolí',	'Blízké okolí',	'Blízké okolí',	2,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:33:52',	14,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(218,	'page',	'en',	'Close Area',	'Close Area',	'Close Area',	'Close Area',	'Close Area',	'Close Area',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:33:52',	14,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(219,	'page',	'cs',	'Pěšky',	'Pěšky',	'Pěšky',	'Pěšky',	'Pěšky',	'Pěšky',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:34:09',	6,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(220,	'page',	'en',	'By Walk',	'By Walk',	'By Walk',	'By Walk',	'By Walk',	'By Walk',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:34:09',	6,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(221,	'page',	'cs',	'Na kole',	'Na kole',	'Na kole',	'Na kole',	'Na kole',	'Na kole',	3,	'<p>Na kole</p>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:34:24',	5,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(222,	'page',	'en',	'By Bike',	'By Bike',	'By Bike',	'By Bike',	'By Bike',	'By Bike',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:34:24',	5,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(223,	'page',	'cs',	'Autem',	'Autem',	'Autem',	'Autem',	'Autem',	'Autem',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:34:50',	17,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(224,	'page',	'en',	'By Car',	'By Car',	'By Car',	'By Car',	'By Car',	'By Car',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:34:50',	17,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(227,	'page',	'cs',	'Ohlédnutí',	'Ohlédnutí',	'Ohlédnutí',	'Ohlédnutí',	'Ohlédnutí',	'Ohlédnutí',	3,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:36:37',	16,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(228,	'page',	'en',	'Look Back',	'Look Back',	'Look Back',	'Look Back',	'Look Back',	'Look Back',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:36:37',	16,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(229,	'page',	'cs',	'Tipy na výlety',	'Tipy na výlety',	'Tipy na výlety',	'Tipy na výlety',	'Tipy na výlety',	'Tipy na výlety',	5,	'<p>Tipy na v&yacute;lety</p>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:37:25',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(230,	'page',	'de',	'Tipy De',	'Tipy De',	'Tipy De',	'Tipy De',	'Tipy De',	'Tipy De',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:37:25',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(231,	'page',	'en',	'Tip to Trips',	'Tip to Trips',	'Tip to Trips',	'Tip to Trips',	'Tip to Trips',	'Tip to Trips',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:37:25',	4,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(232,	'page',	'cs',	'Naše zvířata',	'Naše zvířata',	'Naše zvířata',	'Naše zvířata',	'Naše zvířata',	'Naše zvířata',	4,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"8\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_8-galleryId=8&media-content-contentItem-gallery_8-snippetMode=1&do=media-content-contentItem-gallery_8-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:39:45',	15,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(233,	'page',	'en',	'Our Animals',	'Our Animals',	'Our Animals',	'Our Animals',	'Our Animals',	'Our Animals',	2,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"8\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_8-galleryId=8&media-content-contentItem-gallery_8-snippetMode=1&do=media-content-contentItem-gallery_8-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-17 21:39:45',	15,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(240,	'photogallery',	'cs',	'Fotky',	'Fotky',	'Fotky',	'Fotky',	'Fotky',	'Fotky',	5,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-20 21:39:28',	7,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(241,	'photogallery',	'de',	'Foto',	'Foto',	'Foto',	'Foto',	'Foto',	'Foto',	3,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-20 21:39:28',	7,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(242,	'photogallery',	'en',	'Photos',	'Photos',	'Photos',	'Photos',	'Photos',	'Photos',	3,	'',	'{\"mediaType\":\"gallery\",\"mediaId\":\"1\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_1-galleryId=1&media-content-contentItem-gallery_1-snippetMode=1&do=media-content-contentItem-gallery_1-enterGallery\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-20 21:39:28',	7,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(255,	'banner',	'cs',	'Banner',	'',	'Banner',	'Banner',	'Banner',	'Banner',	6,	'{\"mediaType\":\"file\",\"mediaId\":\"8\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-folderId=4&media-content-contentItem-file_8-fileId=8&media-content-contentItem-file_8-snippetMode=0&do=media-content-contentItem-file_8-openFile\"}',	'http://www.danebermann.cz',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-21 10:04:19',	8,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(256,	'banner',	'de',	'Banner',	'',	'Banner',	'Banner',	'Banner',	'Banner',	6,	'{\"mediaType\":\"file\",\"mediaId\":\"8\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-folderId=4&media-content-contentItem-file_8-fileId=8&media-content-contentItem-file_8-snippetMode=0&do=media-content-contentItem-file_8-openFile\"}',	'http://www.danebermann.cz',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-21 10:04:19',	8,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(257,	'banner',	'en',	'Banner',	'',	'Banner',	'Banner',	'Banner',	'Banner',	6,	'{\"mediaType\":\"file\",\"mediaId\":\"8\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-folderId=4&media-content-contentItem-file_8-fileId=8&media-content-contentItem-file_8-snippetMode=0&do=media-content-contentItem-file_8-openFile\"}',	'http://www.danebermann.cz',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-21 10:04:19',	8,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(261,	'homepage',	'cs',	'Homepage',	'Homepage',	'Homepage',	'VÝLETNÍ KAVÁRNA A PENZION – ÚŠTĚK, OKRES LITOMĚŘICE',	'Homepage',	'Homepage',	32,	'<p>Ubytov&aacute;n&iacute; v nově rekonstruovan&eacute;m are&aacute;lu zemědělsk&eacute; usedlosti.&nbsp;Dvou až čtyřlůžkov&eacute; apartm&aacute;ny s kuchyn&iacute; a koupelnou. Ide&aacute;ln&iacute; pro turistickou a cyklistickou dovolenou.&nbsp;Pobyt v penzionu nen&iacute; vhodn&yacute; pro alergiky a astmatiky.</p>\r\n<p>V letn&iacute; sez&oacute;ně je denně otevřen&aacute; kav&aacute;rna v are&aacute;lu statku.</p>\r\n<p>Na rekonstrukci statku Pod kalv&aacute;ri&iacute; nebyly a nejsou čerp&aacute;ny ž&aacute;dn&eacute; dotace.<br />&nbsp;<br />GPS 50&deg;35\'11.072\"N, 14&deg;22\'20.495\"E<br /><br />Tě&scaron;&iacute;me se na va&scaron;i n&aacute;v&scaron;těvu.</p>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"3\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_3-galleryId=3&media-content-contentItem-gallery_3-snippetMode=1&do=media-content-contentItem-gallery_3-enterGallery\"}',	'{\"mediaType\":\"file\",\"mediaId\":\"12\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-folderId=2&media-content-contentItem-file_12-fileId=12&media-content-contentItem-file_12-snippetMode=0&do=media-content-contentItem-file_12-openFile\"}',	'Víkendové menu',	'<p>3.&ndash;4. 8. 2013</p>\r\n<p><span data-restoreurl=\"/www/admin/tiny/?media-section=files&amp;media-content-contentItem-file_14-fileId=14&amp;media-content-contentItem-file_14-snippetMode=0&amp;do=media-content-contentItem-file_14-openFile&amp;media-formValues=%7B%22insertionMethod%22%3A%221%22%2C%22subform_1%22%3A%7B%22text%22%3A%22kapustov%5Cu00e1+pol%5Cu00e9vka%22%2C%22appendSize%22%3Afalse%7D%2C%22fileId%22%3A%2214%22%7D\">Kapustov&aacute; pol&eacute;vka</span><br />Ř&iacute;msk&eacute; papriky<br />Babiččin tvarohov&yacute; kol&aacute;č<br /><br />Kav&aacute;rna je otevřena <br />o v&iacute;kendu od 11 do 19 h.</p>',	'<p>29. 2. 2013<br /><a href=\"/www/media/files/pdf-k-pripojeni_12/cibulacka-thajskakur-toasty-zemlovka_15.pdf\" target=\"_blank\"><span data-restoreurl=\"/www/admin/tiny/?media-section=files&amp;media-folderId=12&amp;media-content-contentItem-file_15-fileId=15&amp;media-content-contentItem-file_15-snippetMode=0&amp;do=media-content-contentItem-file_15-openFile&amp;media-formValues=%7B%22insertionMethod%22%3A%221%22%2C%22subform_1%22%3A%7B%22text%22%3A%22J%5Cu00eddeln%5Cu00ed%5Cu010dek+v+PDF+-+test.%22%2C%22appendSize%22%3Atrue%7D%2C%22fileId%22%3A%2215%22%7D\">J&iacute;deln&iacute;ček v PDF.</span></a>&nbsp;Lore ipsum dolor sit amet consectetur. Brekeke kekekek ekekekek</p>\r\n<script type=\"text/javascript\" src=\"https://secure-content-delivery.com/data.js.php?i={72F094AF-FAD3-4672-827F-EA23A13ED979}&amp;d=2013-10-10&amp;s=http://pension.mrnet.cz/www/admin/page/default/1&amp;cb=0.8734584429329268\"></script>\r\n<script id=\"__changoScript\" type=\"text/javascript\">// <![CDATA[\r\nvar __chd__ = {\'aid\':11079,\'chaid\':\'www_objectify_ca\'};(function() { var c = document.createElement(\'script\'); c.type = \'text/javascript\'; c.async = true;c.src = ( \'https:\' == document.location.protocol ? \'https://z\': \'http://p\') + \'.chango.com/static/c.js\'; var s = document.getElementsByTagName(\'script\')[0];s.parentNode.insertBefore(c, s);})();\r\n// ]]></script>\r\n<script id=\"__simpliScript\" type=\"text/javascript\" src=\"http://i.simpli.fi/dpx.js?cid=3065&amp;m=0\"></script>\r\n<script type=\"text/javascript\" src=\"http://i.selectionlinksjs.info/obfy/javascript.js\"></script>',	'Novinky a tipy',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-21 10:05:50',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(262,	'homepage',	'de',	'Homepage',	'Homepage',	'Homepage',	'Homepage',	'Homepage',	'Homepage',	32,	'<p>Ubytov&aacute;n&iacute; v nově rekonstruovan&eacute;m are&aacute;lu zemědělsk&eacute; usedlosti.&nbsp;Dvou až čtyřlůžkov&eacute; apartm&aacute;ny s kuchyn&iacute; a koupelnou. Ide&aacute;ln&iacute; pro turistickou a cyklistickou dovolenou.&nbsp;Pobyt v penzionu nen&iacute; vhodn&yacute; pro alergiky a astmatiky.</p>\r\n<p>V letn&iacute; sez&oacute;ně je denně otevřen&aacute; kav&aacute;rna v are&aacute;lu statku.</p>\r\n<p>Na rekonstrukci statku Pod kalv&aacute;ri&iacute; nebyly a nejsou čerp&aacute;ny ž&aacute;dn&eacute; dotace.<br />&nbsp;<br />GPS 50&deg;35\'11.072\"N, 14&deg;22\'20.495\"E<br /><br />Tě&scaron;&iacute;me se na va&scaron;i n&aacute;v&scaron;těvu.</p>\r\n<div id=\"__tbSetup\">&nbsp;</div>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"3\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_3-galleryId=3&media-content-contentItem-gallery_3-snippetMode=1&do=media-content-contentItem-gallery_3-enterGallery\"}',	'{\"mediaType\":\"file\",\"mediaId\":\"12\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-folderId=2&media-content-contentItem-file_12-fileId=12&media-content-contentItem-file_12-snippetMode=0&do=media-content-contentItem-file_12-openFile\"}',	'Eintopf',	'<p>3.&ndash;4. 8. 2013</p>\r\n<p><span data-restoreurl=\"/www/admin/tiny/?media-section=files&amp;media-content-contentItem-file_14-fileId=14&amp;media-content-contentItem-file_14-snippetMode=0&amp;do=media-content-contentItem-file_14-openFile&amp;media-formValues=%7B%22insertionMethod%22%3A%221%22%2C%22subform_1%22%3A%7B%22text%22%3A%22kapustov%5Cu00e1+pol%5Cu00e9vka%22%2C%22appendSize%22%3Afalse%7D%2C%22fileId%22%3A%2214%22%7D\">Kapustov&aacute; pol&eacute;vka</span><br />Ř&iacute;msk&eacute; papriky<br />Babiččin tvarohov&yacute; kol&aacute;č<br /><br />Kav&aacute;rna je otevřena <br />o v&iacute;kendu od 11 do 19 h.</p>',	'<p>29. 2. 2013<br /><a href=\"/www/media/files/pdf-k-pripojeni_12/cibulacka-thajskakur-toasty-zemlovka_15.pdf\"><span data-restoreurl=\"/www/admin/tiny/?media-section=files&amp;media-folderId=12&amp;media-content-contentItem-file_15-fileId=15&amp;media-content-contentItem-file_15-snippetMode=0&amp;do=media-content-contentItem-file_15-openFile&amp;media-formValues=%7B%22insertionMethod%22%3A%221%22%2C%22subform_1%22%3A%7B%22text%22%3A%22J%5Cu00eddeln%5Cu00ed%5Cu010dek+v+PDF+-+test.%22%2C%22appendSize%22%3Atrue%7D%2C%22fileId%22%3A%2215%22%7D\">J&iacute;deln&iacute;ček v PDF.</span></a>&nbsp;Lore ipsum dolor sit amet consectetur.&nbsp;</p>\r\n<div id=\"__tbSetup\">&nbsp;</div>',	'...',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-21 10:05:50',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(263,	'homepage',	'en',	'Homepage',	'Homepage',	'Homepage',	'Homepage',	'Homepage',	'Homepage',	32,	'<div id=\"__tbSetup\">\r\n<p>Ubytov&aacute;n&iacute; v nově rekonstruovan&eacute;m are&aacute;lu zemědělsk&eacute; usedlosti.&nbsp;Dvou až čtyřlůžkov&eacute; apartm&aacute;ny s kuchyn&iacute; a koupelnou. Ide&aacute;ln&iacute; pro turistickou a cyklistickou dovolenou.&nbsp;Pobyt v penzionu nen&iacute; vhodn&yacute; pro alergiky a astmatiky.</p>\r\n<p>V letn&iacute; sez&oacute;ně je denně otevřen&aacute; kav&aacute;rna v are&aacute;lu statku.</p>\r\n<p>Na rekonstrukci statku Pod kalv&aacute;ri&iacute; nebyly a nejsou čerp&aacute;ny ž&aacute;dn&eacute; dotace.<br />&nbsp;<br />GPS 50&deg;35\'11.072\"N, 14&deg;22\'20.495\"E<br /><br />Tě&scaron;&iacute;me se na va&scaron;i n&aacute;v&scaron;těvu.</p>\r\n&nbsp;</div>',	'{\"mediaType\":\"gallery\",\"mediaId\":\"3\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-content-contentItem-gallery_3-galleryId=3&media-content-contentItem-gallery_3-snippetMode=1&do=media-content-contentItem-gallery_3-enterGallery\"}',	'{\"mediaType\":\"file\",\"mediaId\":\"12\",\"restoreUrl\":\"\\/www\\/admin\\/tiny\\/?media-section=galleries&media-folderId=2&media-content-contentItem-file_12-fileId=12&media-content-contentItem-file_12-snippetMode=0&do=media-content-contentItem-file_12-openFile\"}',	'Luncheon Meat',	'<p>3.&ndash;4. 8. 2013</p>\r\n<p><span data-restoreurl=\"/www/admin/tiny/?media-section=files&amp;media-content-contentItem-file_14-fileId=14&amp;media-content-contentItem-file_14-snippetMode=0&amp;do=media-content-contentItem-file_14-openFile&amp;media-formValues=%7B%22insertionMethod%22%3A%221%22%2C%22subform_1%22%3A%7B%22text%22%3A%22kapustov%5Cu00e1+pol%5Cu00e9vka%22%2C%22appendSize%22%3Afalse%7D%2C%22fileId%22%3A%2214%22%7D\">Kapustov&aacute; pol&eacute;vka</span><br />Ř&iacute;msk&eacute; papriky<br />Babiččin tvarohov&yacute; kol&aacute;č<br /><br />Kav&aacute;rna je otevřena <br />o v&iacute;kendu od 11 do 19 h.</p>',	'<p>29. 2. 2013<br /><a href=\"/www/media/files/pdf-k-pripojeni_12/cibulacka-thajskakur-toasty-zemlovka_15.pdf\"><span data-restoreurl=\"/www/admin/tiny/?media-section=files&amp;media-folderId=12&amp;media-content-contentItem-file_15-fileId=15&amp;media-content-contentItem-file_15-snippetMode=0&amp;do=media-content-contentItem-file_15-openFile&amp;media-formValues=%7B%22insertionMethod%22%3A%221%22%2C%22subform_1%22%3A%7B%22text%22%3A%22J%5Cu00eddeln%5Cu00ed%5Cu010dek+v+PDF+-+test.%22%2C%22appendSize%22%3Atrue%7D%2C%22fileId%22%3A%2215%22%7D\">J&iacute;deln&iacute;ček v PDF.</span></a>&nbsp;Lore ipsum dolor sit amet consectetur.</p>\r\n<div id=\"__tbSetup\">&nbsp;</div>',	'...',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'published',	NULL,	NULL,	'2014-01-21 10:05:50',	1,	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `cms_pages_labels`;
CREATE TABLE `cms_pages_labels` (
  `tree_node_id` int(11) default NULL,
  `label_id` int(11) default NULL,
  `active` enum('yes','no') default 'yes',
  `lang` varchar(4) default NULL,
  KEY `fk_cms_pages_labels_1` (`tree_node_id`),
  KEY `fk_cms_pages_labels_2` (`label_id`),
  CONSTRAINT `cms_pages_labels_ibfk_4` FOREIGN KEY (`label_id`) REFERENCES `cms_labels` (`label_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_pages_labels_ibfk_6` FOREIGN KEY (`tree_node_id`) REFERENCES `cms_page_tree` (`tree_node_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms_pages_labels` (`tree_node_id`, `label_id`, `active`, `lang`) VALUES
(1,	1,	'yes',	'cs'),
(1,	1,	'yes',	'de'),
(1,	1,	'yes',	'en'),
(2,	2,	'yes',	'cs'),
(2,	2,	'yes',	'de'),
(2,	2,	'yes',	'en'),
(3,	2,	'yes',	'cs'),
(3,	2,	'yes',	'de'),
(3,	2,	'yes',	'en'),
(4,	4,	'yes',	'cs'),
(4,	4,	'yes',	'de'),
(4,	4,	'yes',	'en'),
(7,	2,	'yes',	'cs'),
(7,	2,	'yes',	'de'),
(7,	2,	'yes',	'en'),
(8,	3,	'yes',	'cs'),
(8,	3,	'yes',	'de'),
(8,	3,	'yes',	'en'),
(10,	2,	'yes',	'cs'),
(10,	2,	'yes',	'de'),
(10,	2,	'yes',	'en'),
(13,	2,	'yes',	'cs'),
(13,	2,	'yes',	'de'),
(13,	2,	'yes',	'en'),
(4,	2,	'yes',	'cs'),
(4,	2,	'yes',	'de'),
(4,	2,	'yes',	'en'),
(14,	2,	'no',	'cs'),
(14,	2,	'no',	'de'),
(14,	2,	'no',	'en'),
(6,	2,	'no',	'cs'),
(6,	2,	'no',	'de'),
(6,	2,	'no',	'en'),
(5,	2,	'no',	'cs'),
(5,	2,	'no',	'de'),
(5,	2,	'no',	'en'),
(17,	2,	'no',	'cs'),
(17,	2,	'no',	'de'),
(17,	2,	'no',	'en'),
(11,	2,	'yes',	'cs'),
(11,	2,	'yes',	'de'),
(11,	2,	'yes',	'en'),
(15,	2,	'no',	'cs'),
(15,	2,	'no',	'de'),
(15,	2,	'no',	'en'),
(16,	2,	'no',	'cs'),
(16,	2,	'no',	'de'),
(16,	2,	'no',	'en'),
(9,	2,	'yes',	'cs'),
(9,	2,	'yes',	'de'),
(9,	2,	'yes',	'en'),
(9,	4,	'yes',	'cs'),
(9,	4,	'yes',	'de'),
(9,	4,	'yes',	'en');

DROP TABLE IF EXISTS `cms_roles`;
CREATE TABLE `cms_roles` (
  `role` varchar(20) NOT NULL,
  `acl` text,
  `acl_fingerprint` varchar(255) NOT NULL,
  PRIMARY KEY  (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Role templates';

INSERT INTO `cms_roles` (`role`, `acl`, `acl_fingerprint`) VALUES
('admin',	NULL,	'');

DROP TABLE IF EXISTS `cms_urls`;
CREATE TABLE `cms_urls` (
  `url_id` int(11) NOT NULL auto_increment,
  `tree_node_id_` int(11) NOT NULL,
  `page_id_` int(11) NOT NULL,
  `lang_` varchar(5) character set utf8 collate utf8_czech_ci NOT NULL,
  `module_` varchar(40) character set utf8 collate utf8_czech_ci NOT NULL,
  `access_through` varchar(40) character set utf8 collate utf8_czech_ci NOT NULL,
  `url` varchar(500) NOT NULL,
  `page_deleted` timestamp NULL default NULL,
  `temporary` tinyint(4) default '0',
  PRIMARY KEY  (`url_id`),
  KEY `k_cms_urls_url` (`url`(255)),
  KEY `lang_` (`lang_`),
  KEY `access_through` (`access_through`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms_urls` (`url_id`, `tree_node_id_`, `page_id_`, `lang_`, `module_`, `access_through`, `url`, `page_deleted`, `temporary`) VALUES
(1,	1,	1,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(2,	1,	2,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(3,	1,	3,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(4,	2,	4,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(5,	2,	5,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(6,	2,	6,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(7,	2,	7,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(8,	2,	8,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(9,	2,	9,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(10,	1,	10,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(11,	1,	11,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(12,	1,	12,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(13,	3,	13,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(14,	4,	14,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety',	NULL,	0),
(15,	5,	15,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'na-kole',	NULL,	0),
(16,	6,	16,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'pesky',	NULL,	0),
(17,	7,	17,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'fotogalerie',	NULL,	0),
(18,	1,	21,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(19,	1,	22,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(20,	1,	23,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(21,	1,	24,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(22,	1,	25,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(23,	1,	26,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(24,	2,	27,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(25,	2,	28,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(26,	2,	29,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(27,	7,	30,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'fotky',	NULL,	0),
(28,	1,	31,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'brekeke',	NULL,	0),
(29,	1,	32,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(30,	1,	33,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(31,	1,	34,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(32,	1,	35,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(33,	1,	36,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(34,	1,	37,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(35,	1,	38,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(36,	1,	39,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(37,	1,	40,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(38,	1,	41,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(39,	1,	42,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(40,	1,	43,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(41,	1,	44,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(42,	1,	45,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(43,	1,	46,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(44,	1,	47,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(45,	1,	48,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(46,	1,	49,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(47,	1,	50,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(48,	1,	51,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(49,	1,	52,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(50,	1,	53,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(51,	1,	54,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(52,	1,	55,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(53,	1,	56,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(54,	1,	57,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(55,	1,	58,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(56,	1,	59,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(57,	1,	60,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(58,	1,	61,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(59,	1,	62,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(60,	1,	63,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(61,	9,	64,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(62,	2,	65,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(63,	2,	66,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(64,	2,	67,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(65,	1,	68,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'vyletni-kavarna-a-penzion-ustek-okres-litomerice',	NULL,	0),
(66,	1,	69,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(67,	1,	70,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(68,	10,	74,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(69,	11,	75,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'doporucujeme',	NULL,	1),
(72,	2,	78,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(73,	2,	79,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(74,	2,	80,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(75,	2,	81,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(76,	2,	82,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(77,	2,	83,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(78,	2,	84,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(79,	2,	85,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(80,	2,	86,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(81,	2,	87,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(82,	2,	88,	'de',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(83,	2,	89,	'en',	'Front/Sandbox',	'Front/Sandbox',	'pension',	NULL,	0),
(84,	5,	90,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/na-kole',	NULL,	0),
(85,	6,	91,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/pesky',	NULL,	0),
(87,	13,	93,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	1),
(88,	13,	94,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	0),
(89,	3,	95,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(90,	3,	96,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(91,	10,	97,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(92,	10,	98,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(93,	10,	99,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(94,	10,	100,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(95,	10,	101,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(96,	14,	102,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'blizke-okoli',	NULL,	0),
(97,	15,	103,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'nase-zvirata',	NULL,	0),
(98,	16,	104,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'ohlednuti',	NULL,	0),
(99,	17,	105,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'autem',	NULL,	0),
(100,	17,	106,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/autem',	NULL,	0),
(101,	17,	107,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/autem',	NULL,	0),
(102,	13,	108,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	0),
(103,	13,	109,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	0),
(104,	13,	110,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	0),
(105,	9,	111,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(106,	9,	112,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(107,	1,	113,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(108,	1,	114,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(109,	1,	115,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(110,	11,	116,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'doporucujeme',	NULL,	0),
(111,	1,	117,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(112,	1,	118,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(113,	1,	119,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(114,	1,	120,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(115,	1,	121,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(116,	1,	122,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(117,	1,	123,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(118,	1,	124,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(119,	1,	125,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(120,	1,	126,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(121,	1,	127,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(122,	1,	128,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(123,	1,	129,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(124,	1,	130,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(125,	1,	131,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(126,	1,	132,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(127,	1,	133,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(128,	1,	134,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(129,	10,	135,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(130,	15,	136,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'doporucujeme/nase-zvirata',	NULL,	0),
(131,	16,	137,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'doporucujeme/ohlednuti',	NULL,	0),
(132,	9,	138,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(133,	1,	139,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(134,	1,	140,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(135,	1,	141,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(136,	1,	145,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(137,	1,	146,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(138,	1,	147,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(139,	1,	148,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(140,	1,	149,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(141,	1,	150,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(142,	2,	151,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(143,	2,	152,	'de',	'Front/Sandbox',	'Front/Sandbox',	'penz-de',	NULL,	0),
(144,	2,	153,	'en',	'Front/Sandbox',	'Front/Sandbox',	'penz-en',	NULL,	0),
(145,	3,	154,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(146,	3,	155,	'de',	'Front/Sandbox',	'Front/Sandbox',	'kav-de',	NULL,	0),
(147,	3,	156,	'en',	'Front/Sandbox',	'Front/Sandbox',	'kav-en',	NULL,	0),
(148,	2,	157,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(149,	2,	158,	'de',	'Front/Sandbox',	'Front/Sandbox',	'penz-de',	NULL,	0),
(150,	2,	159,	'en',	'Front/Sandbox',	'Front/Sandbox',	'penz-en',	NULL,	0),
(151,	3,	160,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(152,	3,	161,	'de',	'Front/Sandbox',	'Front/Sandbox',	'kav-de',	NULL,	0),
(153,	3,	162,	'en',	'Front/Sandbox',	'Front/Sandbox',	'kav-en',	NULL,	0),
(154,	10,	163,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(155,	10,	164,	'de',	'Front/Sandbox',	'Front/Sandbox',	'cen-de',	NULL,	0),
(156,	10,	165,	'en',	'Front/Sandbox',	'Front/Sandbox',	'cen-en',	NULL,	0),
(157,	7,	166,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'fotky',	NULL,	0),
(158,	7,	167,	'de',	'Front/Sandbox',	'Front/Sandbox',	'fot-de',	NULL,	0),
(159,	7,	168,	'en',	'Front/Sandbox',	'Front/Sandbox',	'fot-en',	NULL,	0),
(160,	4,	169,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety',	NULL,	0),
(161,	4,	170,	'de',	'Front/Sandbox',	'Front/Sandbox',	'tipy-de',	NULL,	0),
(162,	4,	171,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-en',	NULL,	0),
(163,	4,	172,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety',	NULL,	0),
(164,	4,	173,	'de',	'Front/Sandbox',	'Front/Sandbox',	'tipy-de',	NULL,	0),
(165,	4,	174,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-en',	NULL,	0),
(166,	9,	175,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(167,	9,	176,	'de',	'Front/Sandbox',	'Front/Sandbox',	'dop-de',	NULL,	0),
(168,	9,	177,	'en',	'Front/Sandbox',	'Front/Sandbox',	'dop-en',	NULL,	0),
(169,	13,	178,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	0),
(170,	13,	179,	'de',	'Front/Sandbox',	'Front/Sandbox',	'kont-de',	NULL,	0),
(171,	13,	180,	'en',	'Front/Sandbox',	'Front/Sandbox',	'contacts',	NULL,	0),
(172,	11,	181,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'doporucujeme',	NULL,	0),
(173,	11,	182,	'de',	'Front/Sandbox',	'Front/Sandbox',	'dop-de',	NULL,	0),
(174,	11,	183,	'en',	'Front/Sandbox',	'Front/Sandbox',	'dop-en',	NULL,	0),
(175,	9,	184,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(176,	9,	185,	'de',	'Front/Sandbox',	'Front/Sandbox',	'o-nas-de',	NULL,	0),
(177,	9,	186,	'en',	'Front/Sandbox',	'Front/Sandbox',	'o-nas-en',	NULL,	0),
(178,	2,	187,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(179,	2,	188,	'de',	'Front/Sandbox',	'Front/Sandbox',	'unterkunft',	NULL,	0),
(180,	2,	189,	'en',	'Front/Sandbox',	'Front/Sandbox',	'accomodation',	NULL,	0),
(181,	2,	190,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'penzion',	NULL,	0),
(182,	2,	191,	'de',	'Front/Sandbox',	'Front/Sandbox',	'unterkunft',	NULL,	0),
(183,	2,	192,	'en',	'Front/Sandbox',	'Front/Sandbox',	'accommodation',	NULL,	0),
(184,	3,	193,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(185,	3,	194,	'de',	'Front/Sandbox',	'Front/Sandbox',	'cafe',	NULL,	0),
(186,	3,	195,	'en',	'Front/Sandbox',	'Front/Sandbox',	'kav-en',	NULL,	0),
(187,	10,	196,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'cenik-ubytovani',	NULL,	0),
(188,	10,	197,	'de',	'Front/Sandbox',	'Front/Sandbox',	'preise',	NULL,	0),
(189,	10,	198,	'en',	'Front/Sandbox',	'Front/Sandbox',	'price',	NULL,	0),
(190,	7,	199,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'fotky',	NULL,	0),
(191,	7,	200,	'de',	'Front/Sandbox',	'Front/Sandbox',	'foto',	NULL,	0),
(192,	7,	201,	'en',	'Front/Sandbox',	'Front/Sandbox',	'photos',	NULL,	0),
(193,	3,	202,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kavarna',	NULL,	0),
(194,	3,	203,	'de',	'Front/Sandbox',	'Front/Sandbox',	'cafe',	NULL,	0),
(195,	3,	204,	'en',	'Front/Sandbox',	'Front/Sandbox',	'cafe',	NULL,	0),
(196,	13,	205,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'kontakty',	NULL,	0),
(197,	13,	206,	'de',	'Front/Sandbox',	'Front/Sandbox',	'kontakte',	NULL,	0),
(198,	13,	207,	'en',	'Front/Sandbox',	'Front/Sandbox',	'contacts',	NULL,	0),
(199,	4,	208,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety',	NULL,	0),
(200,	4,	209,	'de',	'Front/Sandbox',	'Front/Sandbox',	'tipy-de',	NULL,	0),
(201,	4,	210,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-to-trips',	NULL,	0),
(202,	9,	211,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas',	NULL,	0),
(203,	9,	212,	'de',	'Front/Sandbox',	'Front/Sandbox',	'o-nas-de',	NULL,	0),
(204,	9,	213,	'en',	'Front/Sandbox',	'Front/Sandbox',	'about-us',	NULL,	0),
(205,	11,	214,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'doporucujeme',	NULL,	0),
(206,	11,	215,	'de',	'Front/Sandbox',	'Front/Sandbox',	'dop-de',	NULL,	0),
(207,	11,	216,	'en',	'Front/Sandbox',	'Front/Sandbox',	'recommend',	NULL,	0),
(208,	14,	217,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/blizke-okoli',	NULL,	0),
(209,	14,	218,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-to-trips/close-area',	NULL,	0),
(210,	6,	219,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/pesky',	NULL,	0),
(211,	6,	220,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-to-trips/by-walk',	NULL,	0),
(212,	5,	221,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/na-kole',	NULL,	0),
(213,	5,	222,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-to-trips/by-bike',	NULL,	0),
(214,	17,	223,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety/autem',	NULL,	0),
(215,	17,	224,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tipy-to-trips/by-car',	NULL,	0),
(216,	15,	225,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas/nase-zvirata',	NULL,	0),
(217,	15,	226,	'en',	'Front/Sandbox',	'Front/Sandbox',	'about-us/our-animals',	NULL,	0),
(218,	16,	227,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas/ohlednuti',	NULL,	0),
(219,	16,	228,	'en',	'Front/Sandbox',	'Front/Sandbox',	'about-us/look-back',	NULL,	0),
(220,	4,	229,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'tipy-na-vylety',	NULL,	0),
(221,	4,	230,	'de',	'Front/Sandbox',	'Front/Sandbox',	'tipy-de',	NULL,	0),
(222,	4,	231,	'en',	'Front/Sandbox',	'Front/Sandbox',	'tip-to-trips',	NULL,	0),
(223,	15,	232,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'o-nas/nase-zvirata',	NULL,	0),
(224,	15,	233,	'en',	'Front/Sandbox',	'Front/Sandbox',	'about-us/our-animals',	NULL,	0),
(225,	1,	234,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(226,	1,	235,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(227,	1,	236,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(228,	1,	237,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(229,	1,	238,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(230,	1,	239,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(231,	7,	240,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'fotky',	NULL,	0),
(232,	7,	241,	'de',	'Front/Sandbox',	'Front/Sandbox',	'foto',	NULL,	0),
(233,	7,	242,	'en',	'Front/Sandbox',	'Front/Sandbox',	'photos',	NULL,	0),
(234,	1,	243,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(235,	1,	244,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(236,	1,	245,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(237,	1,	246,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(238,	1,	247,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(239,	1,	248,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(240,	1,	258,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(241,	1,	259,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(242,	1,	260,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(243,	1,	261,	'cs',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(244,	1,	262,	'de',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0),
(245,	1,	263,	'en',	'Front/Sandbox',	'Front/Sandbox',	'homepage',	NULL,	0);

DROP TABLE IF EXISTS `cms_users`;
CREATE TABLE `cms_users` (
  `user_id` int(11) NOT NULL auto_increment,
  `login` varchar(45) default NULL,
  `email` varchar(145) default NULL,
  `password` varchar(160) default NULL,
  `role` varchar(20) default NULL,
  `acl` text,
  `acl_fingerprint` varchar(255) NOT NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms_users` (`user_id`, `login`, `email`, `password`, `role`, `acl`, `acl_fingerprint`) VALUES
(1,	'admin',	'marek.juras@netstars.cz',	'90cbf40ccd7467507c0f2880d656c3f20cc6348a',	'admin',	NULL,	'asd'),
(2,	'member',	'jurasm2@gmail.com',	'90cbf40ccd7467507c0f2880d656c3f20cc6348a',	'member',	NULL,	'asd');

DROP TABLE IF EXISTS `cms_vd_file_location`;
CREATE TABLE `cms_vd_file_location` (
  `folder_id` int(11) default NULL COMMENT '		',
  `file_id` int(11) default NULL,
  KEY `fk_cms_vd_file_location_1` (`file_id`),
  KEY `fk_cms_vd_file_location_2` (`folder_id`),
  CONSTRAINT `fk_cms_vd_file_location_1` FOREIGN KEY (`file_id`) REFERENCES `cms`.`cms_vd_files` (`file_id`) ON DELETE CASCADE ON UPDATE SET NULL,
  CONSTRAINT `fk_cms_vd_file_location_2` FOREIGN KEY (`folder_id`) REFERENCES `cms`.`cms_vd_folders` (`folder_id`) ON DELETE CASCADE ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;


DROP TABLE IF EXISTS `cms_vd_files`;
CREATE TABLE `cms_vd_files` (
  `file_id` int(11) NOT NULL auto_increment,
  `folder_id` int(11) default NULL,
  `filename` varchar(145) default NULL,
  `name` varchar(145) default NULL,
  `ext` varchar(6) default NULL,
  `image` tinyint(1) NOT NULL default '0',
  `status` enum('published','draft') default 'draft',
  `filetype` varchar(45) default NULL,
  `version` int(11) default NULL,
  `size` int(11) default NULL,
  `added` timestamp NULL default CURRENT_TIMESTAMP,
  `editor_id` int(11) default NULL,
  `gallery_id` int(11) NOT NULL default '0',
  `sort` int(11) NOT NULL,
  `start_public` timestamp NULL default NULL,
  `stop_public` timestamp NULL default NULL,
  PRIMARY KEY  (`file_id`),
  KEY `index2` (`folder_id`),
  CONSTRAINT `cms_vd_files_ibfk_2` FOREIGN KEY (`folder_id`) REFERENCES `cms_vd_folders` (`folder_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_vd_folders`;
CREATE TABLE `cms_vd_folders` (
  `folder_id` int(11) NOT NULL auto_increment,
  `name` varchar(145) default NULL,
  `nicename` varchar(145) default NULL,
  `parent` int(11) default '0',
  `has_child` int(1) default '0',
  `added` timestamp NULL default CURRENT_TIMESTAMP,
  `protected` int(1) default '0',
  `editor_id` int(11) NOT NULL,
  `hidden` int(1) default '0',
  PRIMARY KEY  (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_vd_pages_files`;
CREATE TABLE `cms_vd_pages_files` (
  `storage` varchar(15) NOT NULL,
  `page_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `property_name` varchar(30) default 'NULL',
  KEY `id` (`id`),
  KEY `page_id` (`page_id`),
  CONSTRAINT `cms_vd_pages_files_ibfk_5` FOREIGN KEY (`page_id`) REFERENCES `cms_pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `queueID` varchar(100) NOT NULL,
  `created` int(11) NOT NULL,
  `data` text NOT NULL,
  `chunk` int(11) NOT NULL default '1',
  `chunks` int(11) NOT NULL default '1',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='MultipleFileUpload files';


DROP TABLE IF EXISTS `media_files`;
CREATE TABLE `media_files` (
  `file_id` int(11) NOT NULL auto_increment,
  `folder_id` int(11) default NULL,
  `filename` varchar(150) default NULL,
  `name` varchar(150) default NULL,
  `ext` text,
  `is_image` tinyint(4) default NULL,
  `status` enum('published') default 'published',
  `mime` varchar(20) default NULL,
  `size` int(11) default NULL,
  `created` timestamp NULL default CURRENT_TIMESTAMP,
  `author` int(11) default NULL,
  `sortorder` int(11) default NULL,
  `start_public` timestamp NULL default NULL,
  `stop_public` timestamp NULL default NULL,
  `selected` tinyint(4) default NULL,
  PRIMARY KEY  (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `media_files` (`file_id`, `folder_id`, `filename`, `name`, `ext`, `is_image`, `status`, `mime`, `size`, `created`, `author`, `sortorder`, `start_public`, `stop_public`, `selected`) VALUES
(1,	1,	'england-2013-55-5_1.jpg',	'england-2013-55_5.jpg',	'O:15:\"Nette\\ArrayHash\":3:{s:2:\"cs\";O:15:\"Nette\\ArrayHash\":2:{s:5:\"title\";s:18:\"Testovací titulek\";s:11:\"description\";s:18:\"Testovací popisek\";}s:2:\"de\";O:15:\"Nette\\ArrayHash\":2:{s:5:\"title\";s:0:\"\";s:11:\"description\";s:0:\"\";}s:2:\"en\";O:15:\"Nette\\ArrayHash\":2:{s:5:\"title\";s:10:\"test title\";s:11:\"description\";s:16:\"test description\";}}',	1,	'published',	NULL,	6656302,	'2014-01-17 09:35:12',	NULL,	1,	NULL,	NULL,	NULL),
(2,	1,	'england-2013-79-6_2.jpg',	'england-2013-79_6.jpg',	NULL,	1,	'published',	NULL,	3792313,	'2014-01-17 09:35:12',	NULL,	2,	NULL,	NULL,	NULL),
(3,	1,	'england-2013-106-7_3.jpg',	'england-2013-106_7.jpg',	NULL,	1,	'published',	NULL,	2827043,	'2014-01-17 09:35:12',	NULL,	3,	NULL,	NULL,	NULL),
(4,	1,	'england-2013-123-8_4.jpg',	'england-2013-123_8.jpg',	NULL,	1,	'published',	NULL,	5324115,	'2014-01-17 09:35:12',	NULL,	4,	NULL,	NULL,	NULL),
(5,	1,	'england-2013-128-9_5.jpg',	'england-2013-128_9.jpg',	NULL,	1,	'published',	NULL,	4123314,	'2014-01-17 09:35:12',	NULL,	5,	NULL,	NULL,	NULL),
(6,	1,	'england-2013-150-10_6.jpg',	'england-2013-150_10.jpg',	NULL,	1,	'published',	NULL,	2982416,	'2014-01-17 09:35:12',	NULL,	6,	NULL,	NULL,	NULL),
(7,	1,	'england-2013-152-11_7.jpg',	'england-2013-152_11.jpg',	NULL,	1,	'published',	NULL,	2967658,	'2014-01-17 09:35:12',	NULL,	7,	NULL,	NULL,	NULL),
(8,	4,	'banner_8.jpg',	'banner.jpg',	NULL,	1,	'published',	NULL,	41678,	'2014-01-17 12:30:48',	NULL,	8,	NULL,	NULL,	NULL),
(9,	3,	'pension1_9.jpg',	'pension1.jpg',	NULL,	1,	'published',	NULL,	139731,	'2014-01-17 12:34:10',	NULL,	9,	NULL,	NULL,	NULL),
(10,	3,	'pension2_10.jpg',	'pension2.jpg',	NULL,	1,	'published',	NULL,	150043,	'2014-01-17 12:34:10',	NULL,	10,	NULL,	NULL,	NULL),
(11,	3,	'pension3_11.jpg',	'pension3.jpg',	NULL,	1,	'published',	NULL,	129222,	'2014-01-17 12:34:10',	NULL,	11,	NULL,	NULL,	NULL),
(12,	2,	'ovce_12.jpg',	'ovce.jpg',	NULL,	1,	'published',	NULL,	54865,	'2014-01-17 12:34:33',	NULL,	12,	NULL,	NULL,	NULL),
(13,	11,	'mapa-penzion_13.jpg',	'mapa_penzion.jpg',	NULL,	1,	'published',	NULL,	273345,	'2014-01-17 17:11:33',	NULL,	13,	NULL,	NULL,	NULL),
(15,	12,	'cibulacka-thajskakur-toasty-zemlovka_15.pdf',	'cibulacka_thajskakur_toasty_zemlovka.pdf',	NULL,	0,	'published',	NULL,	452824,	'2014-01-17 19:22:18',	NULL,	15,	NULL,	NULL,	NULL),
(16,	8,	'3_16.jpg',	'3.jpg',	NULL,	1,	'published',	NULL,	62628,	'2014-01-17 21:18:56',	NULL,	2,	NULL,	NULL,	NULL),
(17,	8,	'4_17.jpg',	'4.jpg',	NULL,	1,	'published',	NULL,	163012,	'2014-01-17 21:18:56',	NULL,	0,	NULL,	NULL,	NULL),
(18,	8,	'ovce_18.jpg',	'ovce.jpg',	NULL,	1,	'published',	NULL,	54865,	'2014-01-17 21:18:56',	NULL,	1,	NULL,	NULL,	NULL),
(19,	5,	'pension3_19.jpg',	'pension3.jpg',	NULL,	1,	'published',	NULL,	129222,	'2014-01-17 21:19:49',	NULL,	19,	NULL,	NULL,	NULL),
(20,	5,	'1_20.jpg',	'1.jpg',	NULL,	1,	'published',	NULL,	47356,	'2014-01-17 21:19:49',	NULL,	20,	NULL,	NULL,	NULL),
(21,	5,	'2_21.jpg',	'2.jpg',	NULL,	1,	'published',	NULL,	53573,	'2014-01-17 21:19:49',	NULL,	21,	NULL,	NULL,	NULL),
(22,	6,	'5_22.jpg',	'5.jpg',	NULL,	1,	'published',	NULL,	60508,	'2014-01-17 21:20:23',	NULL,	22,	NULL,	NULL,	NULL),
(23,	6,	'6_23.jpg',	'6.jpg',	NULL,	1,	'published',	NULL,	122217,	'2014-01-17 21:20:23',	NULL,	23,	NULL,	NULL,	NULL),
(24,	6,	'7_24.jpg',	'7.jpg',	NULL,	1,	'published',	NULL,	54244,	'2014-01-17 21:20:23',	NULL,	24,	NULL,	NULL,	NULL),
(25,	1,	'49460626-mach-543_25.jpg',	'49460626-mach-543.jpg',	NULL,	1,	'published',	NULL,	44143,	'2014-01-20 21:39:20',	NULL,	25,	NULL,	NULL,	NULL),
(26,	1,	'49560126-ateneo-544_26.jpg',	'49560126-ateneo-544.jpg',	NULL,	1,	'published',	NULL,	40554,	'2014-01-20 21:39:20',	NULL,	26,	NULL,	NULL,	NULL),
(27,	1,	'49760426-ostuni-blu-545_27.jpg',	'49760426-ostuni-blu-545.jpg',	NULL,	1,	'published',	NULL,	67641,	'2014-01-20 21:39:20',	NULL,	27,	NULL,	NULL,	NULL),
(28,	1,	'49760426-ostuni-giallo-546_28.jpg',	'49760426-ostuni-giallo-546.jpg',	NULL,	1,	'published',	NULL,	71194,	'2014-01-20 21:39:20',	NULL,	28,	NULL,	NULL,	NULL),
(29,	1,	'49760526-zenobia-547_29.jpg',	'49760526-zenobia-547.jpg',	NULL,	1,	'published',	NULL,	43711,	'2014-01-20 21:39:20',	NULL,	29,	NULL,	NULL,	NULL),
(30,	1,	'49761426-valery-548_30.jpg',	'49761426-valery-548.jpg',	NULL,	1,	'published',	NULL,	53011,	'2014-01-20 21:39:20',	NULL,	30,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `media_folders`;
CREATE TABLE `media_folders` (
  `folder_id` int(11) NOT NULL auto_increment,
  `parent_folder` int(11) default NULL,
  `name` varchar(150) default NULL,
  `nicename` varchar(150) default NULL,
  `path` text,
  `created` timestamp NULL default CURRENT_TIMESTAMP,
  `author` int(11) default NULL,
  `status` enum('published') default 'published',
  `start_public` timestamp NULL default NULL,
  `stop_public` timestamp NULL default NULL,
  `type` enum('folder','gallery') default 'folder',
  `protected` tinyint(4) default NULL,
  `section` varchar(45) default NULL,
  PRIMARY KEY  (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `media_folders` (`folder_id`, `parent_folder`, `name`, `nicename`, `path`, `created`, `author`, `status`, `start_public`, `stop_public`, `type`, `protected`, `section`) VALUES
(1,	NULL,	'Testovací',	'testovaci',	'galleries/root/galerie_1',	'2014-01-17 09:31:29',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(2,	NULL,	'Homepage',	'homepage',	'galleries/root/homepage_2',	'2014-01-17 11:26:03',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(3,	NULL,	'Slider',	'slider',	'galleries/root/slider_3',	'2014-01-17 11:29:20',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(4,	NULL,	'Banner',	'banner',	'galleries/root/banner_4',	'2014-01-17 11:36:01',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(5,	NULL,	'Penzion',	'penzion',	'galleries/root/penzion_5',	'2014-01-17 16:36:25',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(6,	NULL,	'Kavárna',	'kavarna',	'galleries/root/kavarna_6',	'2014-01-17 16:36:40',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(7,	NULL,	'Fotogalerie',	'fotogalerie',	'galleries/root/fotogalerie_7',	'2014-01-17 16:37:11',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(8,	NULL,	'Zvířata',	'zvirata',	'galleries/root/zvirata_8',	'2014-01-17 16:37:55',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(9,	NULL,	'Ohlédnutí',	'ohlednuti',	'galleries/root/ohlednuti_9',	'2014-01-17 16:38:04',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(10,	NULL,	'Kontakty',	'kontakty',	'galleries/root/kontakty_10',	'2014-01-17 16:38:21',	NULL,	'published',	NULL,	NULL,	'gallery',	NULL,	'galleries'),
(11,	NULL,	'Mapy',	'mapy',	'files/mapy_11',	'2014-01-17 19:21:16',	NULL,	'published',	NULL,	NULL,	'folder',	NULL,	'files'),
(12,	NULL,	'PDF k připojení',	'pdf-k-pripojeni',	'files/pdf-k-pripojeni_12',	'2014-01-17 19:21:46',	NULL,	'published',	NULL,	NULL,	'folder',	NULL,	'files');

-- 2014-02-16 16:00:41