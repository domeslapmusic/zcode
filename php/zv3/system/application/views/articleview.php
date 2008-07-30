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

$this->load->view("menuview"); 

?>

<?php if($article->loaded == true){ ?>

<h1><?php echo $article->title; ?></h1>

<a name="inicio"></a>
<div id="contenido">

<?php } ?>

<?php  $this->load->view($article->template); ?>

<?php if($article->loaded == true){ 

$footer = "articlefooter_".$language->shortID; 

$this->load->view($footer); 

?>

</div>
<div id="license">
<a rel="license" href="http://creativecommons.org/licenses/by/3.0/">
<img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" />
</a>
<br />This work is licenced under a 
<a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Licence</a>.
</div>

<?php } ?>