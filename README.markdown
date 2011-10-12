# TouchXML

## Introduction

TouchXML is a lightweight replacement for Cocoa's NSXML* cluster of
classes. It is based on the commonly available Open Source libxml2
library.

## License

This code is licensed under the 2-clause BSD license ("Simplified BSD License" or "FreeBSD License")
license. The license is reproduced below:

Copyright 2011 Jonathan Wight. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY JONATHAN WIGHT ''AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL JONATHAN WIGHT OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Jonathan Wight.

## Automatic Reference Counting (ARC)

The "master" branch of TouchJSON does NOT use Automatic Reference Counting (ARC).

There is a branch that does use ARC - this is found at "features/ARC".

Most new development occurs on the ARC branch. At some point the non-ARC branch will put into
maintenance mode and the ARC branch will become the primary branch.

## Goals

The goal is to create a lightweight  NSXML* style XML api that can used
in environments without NSXML* (e.g. iPhone).

* XML read only. The aim is to make a lite API for reading XML. I'm
assuming most applications will only need to read XML and wont need to
generate it (AJAX applications tend to receive XML data but transmit
data via URL or HTTP form-encoding). Please let me know if your
application needs XML write support.

* Lightweight. Rarely used NSXML* functionality should not be
implemented.

See http://github.com/TouchCode/TouchXML for more.
