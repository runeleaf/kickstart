<?php
class BaseHelper
{

	public function h($str)
	{
		return htmlspecialchars($str);
	}

	public function image_tag($path, $opt=null)
	{
		if(is_null($path) || $path==''){
			return "";
        }else{
            if(isset($opt['width']))
                $width = "width='{$opt['width']}'";
            if(isset($opt['height']))
                $height = "height='{$opt['height']}'";

			return "<img src='{$path}' alt='' title='' {$width} {$height}/>";
		}
	}

	public function link_to($str, $url=null)
	{
		return "<a href='$url'>{$this->h($str)}</a>";
	}
}
