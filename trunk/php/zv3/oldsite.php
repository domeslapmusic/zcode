<?php

	if(isset($_GET["section"])){
		
		$section = $_GET["section"];
		
		$rootPath = "http://zarate.tv/";
		
		switch($section){
			
			case("portfolioDetail"):
			case("portfolio"):
				header("Location:".$rootPath."portfolio");breaK;
			case("home"):
				header("Location:".$rootPath."es");break;
			case("about"):
				header("Location:".$rootPath."personal");break;
			case("proyectos"):
				header("Location:".$rootPath."proyectos");break;
			case("articulos"):
				header("Location:".$rootPath."articulos");break;
			case("css"):
				header("Location:".$rootPath."es");break;
			default:
				break;
		}
		
	}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
	
	<title>Z&aacute;rate</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
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

	<h1>Z&aacute;rate no encuentra lo que buscas :|</h1>
	
	<p>Hay una <a href="http://zarate.tv">nueva versi&oacute;n</a> de esta web. He tratado de &quot;recuperar&quot; todos los enlaces de la versi&oacute;n anterior, pero si est&aacute;s leyendo esto es que algo me he dejado. Mis disculpas!</p>
	
	<p>Juan Delgado - <a href="http://zarate.tv">Z&aacute;rate</a></p>
	
</body>
</html>