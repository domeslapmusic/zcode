<!--

<?php 

/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

echo utf8_encode($misc_freak_warning); 

?>

-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $language->shortID; ?>" lang="<?php echo $language->shortID; ?>">
<head>
	
	<title>Z&aacute;rate <?php if(isset($secondaryTitle)){ echo " - ".$secondaryTitle; } ?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<base href="<?php echo base_url(); ?>" />
	
	<?php if(isset($pageCss)){ foreach($pageCss as $css){ ?>
	<link rel="stylesheet" href="css/<?php echo $css; ?>" type="text/css" media="screen" />
	<?php } } ?>
	
	<?php if(isset($pageJS)){ foreach($pageJS as $js){ ?>
	<script type="text/javascript" src="js/<?php echo $js; ?>"></script>
	<?php } } ?>
	
	<script type="text/javascript">
		
		var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
		document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
		
	</script>
	
	<script type="text/javascript">
		
		var pageTracker = _gat._getTracker("UA-158766-1");
		pageTracker._initData();
		pageTracker._trackPageview();
		
	</script>
	
</head>
<body>

<?php $this->load->view($contentView); ?>

</body>
</html>