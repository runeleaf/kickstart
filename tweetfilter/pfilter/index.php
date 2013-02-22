<?php
require_once("config.php");
require_once('helper.php');
$helper = new BaseHelper();

$stmt = $db->query("select id,status_id,via,screen_name,entry,source,published_at from statuses order by created_at desc limit 100");
?>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>pfilter</title>
<link href="/css/main.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/css/scaffold.css" media="screen" rel="stylesheet" type="text/css" />
</head>
<body>

<div id="wrapper">
<div id="contents">
<h1>Listing statuses</h1>
<table>
<?
$i=0;
while($s = $stmt->fetch(PDO::FETCH_ASSOC)):
	$i++;
	$class = ($i%2==0) ? 'cycle_a' : 'cycle_b';
?>
	<tr class="<?= $class ?>">
	<td rowspan='3'><?= $helper->image_tag($s["via"], array('width' => 48, 'height' => 48)) ?></td>
	</tr>
	<tr class="<?= $class ?>">
	<td colspan='2'><?= $helper->link_to($s["screen_name"], "http://twitter.com/{$s["screen_name"]}") ?>: <?= $helper->h($s["entry"]) ?></td>
	</tr>
	<tr class="<?= $class ?>">
	<td><?= html_entity_decode($s["source"]) ?></td>
	<td><?= $helper->link_to($s["published_at"], "http://twitter.com/{$s["screen_name"]}/status/{$s["status_id"]}") ?></td>
	</tr>
<? endwhile; ?>
</table>
</div>
</div>

</body>
</html>

