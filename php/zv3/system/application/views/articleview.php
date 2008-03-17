<?php  $this->load->view("menuview"); ?>

<h1><?php echo $article->title; ?></h1>

<a name="inicio"></a>
<div id="contenido">
<?php  $this->load->view("articles/".$article->rewrite); ?>

<a href="<?php echo $article->url; ?>" title="Enlace directo a este art&iacute;culo">Enlace directo a este art&iacute;culo</a>
<br />Sugerencias, errores o cualquier duda sobre este articulo en <a href="javascript:noBot('articulos','zarate.tv','<?php echo $article->emailID; ?>')" title="Enviar mail al autor sobre este art&iacute;culo">articulos   [arroba]   zarate.tv</a>
<br />
<a href="articulos/" title="M&aacute;s art&iacute;culos">M&aacute;s art&iacute;culos en Zarate.tv</a>
<p class="subir"><a href="<?php echo $article->url; ?>#inicio" title="Volver al comienzo del art&iacute;culo">Subir</a></p>

</div>
<div id="license">
<a rel="license" href="http://creativecommons.org/licenses/by/3.0/">
<img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" />
</a>
<br />This work is licenced under a 
<a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Licence</a>.
</div>