<?php
ini_set('mbstring.language', 'Japanese');
ini_set('mbstring.internal_encoding', 'UTF-8');
ini_set('mbstring.http_output', 'UTF-8');

//OAuth
define('OAUTHTOKEN','');
define('OAUTHSECRET','');
define('ACCESSTOKEN','');
define('ACCESSSECRET','');

// データベース
$db = null;
try {
    $db = new PDO("mysql:host=localhost; dbname=pfilter","root", "");
    $stmt = $db -> query("SET NAMES utf8;");
} catch(PDOException $e){
	var_dump($e->getMessage());
}
// 切断
//$db = null;

// フィルターワード
$___keyword = array(
	'ok' => array(
		'テスト',
		'サンプル'
	),
	'ng' => array(
		'無料',
		'情報'
	)
);

