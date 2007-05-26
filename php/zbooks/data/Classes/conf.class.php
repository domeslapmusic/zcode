<?

if (!defined('IN_ZBOOKS') ){
	die("Hacking attempt");
}

class conf{
	
	var $pageTitle = "ZBooks - ";
	var $cookiePref = "ZBKS_";
	var $cookieLang = "Lang";
	var $cookieTime = 31536000;
	var $defaultLang = "es";
	
	/* paths */
	var $appRoot = "";
	var $dataFolder = "data/";
	var $classPath = "Classes/";
	var $templateFolder = "Templates/";
	var $compiledTemplateFolder = "Smarty/CompiledTemplates/";
	var $commonPath = "data/comunes/";
	var $tmpPath = "tmp/";
	
	/* templates */
	var $mainTemplate = "site.tpl";
	var $error403 = "errores/403.tpl";
	var $error404 = "errores/404.tpl";
	
	/* db tables */
	var $ZSite_lang = "idiomas";
	
	function conf($_appRoot){
		$this->appRoot = $_appRoot;
		$this->dataFolder = $this->appRoot.$this->dataFolder;
		$this->commonPath = $this->appRoot.$this->commonPath;
	}

	function getTempPath(){
		return $this->dataFolder.$this->tmpPath;
	}
	
	function getClassPath(){
		return $this->dataFolder.$this->classPath;
	}
	
	function getTemplateFolder(){
		return $this->dataFolder.$this->templateFolder;
	}
	
	function getCompiledTemplateFolder(){
		return $this->getClassPath().$this->compiledTemplateFolder;
	}

	function getCookieLang(){
		return $this->cookiePref.$this->cookieLang;
	}
	
}

?>
