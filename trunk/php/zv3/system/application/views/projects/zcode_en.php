<p>ZCode is&nbsp;the place where I keep my code and also a
little AS2 framework (AS3 is on its way).</p>
<h2>The framework</h2>
<p>The framework&nbsp;consists only in 3 "main"
classes&nbsp;
(model, view and configuration object) and a bunch of "helpers"
(FlashVars access, handling right click menu, etc).</p>
<p>The main idea behind ZCode is that it should be the base for
your own
framework. Take a look, pick up anything you might find interesting and
leave everything else. Although it's fully functional, it's on purpose
also *very*
simple. I hope it helps&nbsp;you out pick up the idea and develop
your own-personalized framework.</p>
<p>As I use <a href="http://mtasc.org">MTASC</a>
for my daily job, the code compiles without problems on it. Actually,
you might get some warnings when compiling in Flash IDE. For example,
official Flash compiler doesn't like code before calling <em>super</em>
in
classes' constructors. Sometimes you get a warning (sometimes you
don't) but still compiles the whole thing. If you work in AS2, give
yourself a treat and take a look to MTASC or <a href="http://osflash.org/projects/flasc">FLASC</a>
(Flash IDE + MTASC).</p>
<p>If you want documentation I wrote a little document explaining
why building and using
your own&nbsp;framework is interesting; it also explains how to
begin using ZCode. I'm afraid that the document currently is only
available in <a href="<?php echo base_url(); ?>assets/projects/zcode/zcode.pdf">Spanish</a>, but
don't let that scare you! You can still get the code (all in English)
and take a look.</p>
<p>To start with, just go to the <a href="http://zcode.googlecode.com/svn/trunk/as2/tv/zarate/projects/demo/zcode/">Hello
World</a> application and look at the code. Hopefully it should be pretty self-explanatory.</p>
<h2>The repository</h2>
<p>Currently I'm using Google Code to host the files, you can
find them in
<a href="http://zcode.googlecode.com">http://zcode.googlecode.com</a>
or just point your favourite SVN client to <a href="http://zcode.googlecode.com/svn/">http://zcode.googlecode.com/svn/</a>.
You'll find
a bunch of AS2, some PHP and hopefully haXe and AS3 in the future.
</p>
<p>Please notice that ZCode is my *personal* repository. I try to
keep
things tidy (as a self-imposed rule) but sometimes I just commit stuff
so it doesn't
live only in my box. I do this both for safety reasons (hard disks *do*
break
down without telling you in advance) and also because maybe someone
might find something useful that it's not yet documented. Feel free to
browse and lurk around as much as you
want.</p>
<h2>The projects</h2>
<p>The "official" and more or less documented projects are listed
bellow. Everything else... use at your own risk!</p>
<h3>ZLog</h3>
<p>ZLog is a really simple log console for Flash. It goes
specially well with MTASC. Just check out its own page: <a href="proyectos/zlog/">ZLog</a>.</p>
<h3>ZWeb version 3</h3>
<p>Latest version of my web is built using ZCode. Just check it
out in projects &gt; webv3 and the backend in php &gt;
zv3. BTW, the PHP part is using <a href="http://www.codeigniter.com/">Code Igniter</a>, a
really nice Rail-esque framework that I've been playing with. Give it a
go if you don't have a PHP framework already.</p>

<p class="license">ZCode is released under <a href="http://en.wikipedia.org/wiki/Mit_license">MIT license</a> which allows even commercial use. If you have any doubts please contact me in cuentame [thingy] zarate .tv.</p>

<p>Juan Delgado - <a href="http://zarate.tv">Z&aacute;rate</a></p>