<?php
require('config.php');
$url = 'http://search.twitter.com/search.json';
$ngwords = array();
foreach($___keyword['ng'] as $word){
	$ngwords[] = "-".$word;
}
$ng = implode($ngwords, ' ');
foreach($___keyword['ok'] as $q){
	$query = $q.' '.$ng;
	$params = http_build_query(array('q' => $query, 'lang' => 'ja', 'rpp' => 100));
	$results = json_decode(file_get_contents("$url?$params"), true);
}

$find = $db->prepare("select id from statuses where status_id = :status_id");
$insert = $db->prepare("insert into statuses(status_id,via,screen_name,entry,source,published_at,created_at) values(:status_id,:via,:screen_name,:entry,:source,:published_at,NOW())");

foreach($results['results'] as $r){
	$find->execute(array(':status_id' => $r["id"]));
	$res = $find->fetchAll();
	if(count($res) > 0)
		continue;
	$insert->bindParam(':status_id', $r["id"]);
	$insert->bindParam(':via', $r["profile_image_url"]);
	$insert->bindParam(':screen_name', $r["from_user"]);
	$insert->bindParam(':entry', $r["text"]);
	$insert->bindParam(':source', $r["source"]);
	$date = date("Y-m-d H:i:s", strtotime($r["created_at"]));
	$insert->bindParam(':published_at', $date);
	$insert->execute();
}

echo '<pre>';
echo 'tracking and filtering finish.';
echo '</pre>';

exit(1);
