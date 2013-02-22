<?php
require_once dirname(dirname(dirname(__FILE__))).'/lib/limonade.php';

function configure()
{
	option('env', ENV_DEVELOPMENT);
}

dispatch('/', function(){
	set('page_title', "using content_for()");
	return html('index.html.php', 'layout.html.php');
});
                
run();
