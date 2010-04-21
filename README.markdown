= Introduction =

TouchXML is a lightweight replacement for Cocoa's NSXML* cluster of
classes. It is based on the commonly available Open Source libxml2
library.

= License =

TouchXML is released under the Modified BSD license.

= Goals =

The goal is to create a lightweight  NSXML* style XML api that can used
in environments without NSXML* (e.g. iPhone).

* XML read only. The aim is to make a lite API for reading XML. I'm
assuming most applications will only need to read XML and wont need to
generate it (AJAX applications tend to receive XML data but transmit
data via URL or HTTP form-encoding). Please let me know if your
application needs XML write support.

* Lightweight. Rarely used NSXML* functionality should not be
implemented.

See http://code.google.com/p/touchcode/wiki/TouchXML for more.