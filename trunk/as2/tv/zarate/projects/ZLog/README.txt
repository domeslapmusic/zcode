Zárate - ZLog
--------------------------------------

Si al abrir ZLog sólo aparece "Setting up ZLog..." y nada más, probablemente el player de Flash estará bloqueando la comunicación Flash -> JavaScript en un archivo ejecutado localmente por cuestiones de seguridad.

Para solucionarlo, tienes que añadir la ubicación de ZLog a las zonas "seguras" en la configuración del player aquí:

http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html

ZLog NO estará funcionando hasta que no aparezca el mensaje "ZLog up and running..."

Para compilar con MTASC:

%mtasc% -swf ZLog.swf -header 1:1:31 -version 8 -strict -cp C:\ruta\a\tus\clases -main ZLog.as

Para compilar con Flash IDE simplemente pon lo siguiente en la de tiempo principal:

import tv.zarate.Projects.ZLog;
ZLog.main(this);


Para más información:

http://www.zarate.tv/proyectos/zlog/

--------------------------------------

If you open ZLog and just "Setting up ZLog..." message appears, probably the Flash player is blocking the Flash -> JavaScript communication in a local file due security reasons.

To fix this, you have to add ZLog's location to the "secure" zone here:

http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html

ZLog will NOT be running until the "ZLog up and running..." message appears.

To compile with MTASC

%mtasc% -swf ZLog.swf -header 1:1:31 -version 8 -strict -cp C:\path\to\your\classes -main ZLog.as

To compile from Flash IDE just add this to the main timeline:

import tv.zarate.Projects.ZLog;
ZLog.main(this);


For more information:

http://www.zarate.tv/proyectos/zlog/
