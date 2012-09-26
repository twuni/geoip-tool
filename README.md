This lightweight tool uses the MaxMind GeoIP C API to print geographical information about a given set of IP addresses.

Usage
-----

Here is an example:

    $ geoip 173.194.33.36
    173.194.33.36	Mountain View, CA	United States	(37.419201,-122.057404)

The syntax is as follows:

    $ geoip <ip1> <ip2> ... <ipN>

Prerequisites
-------------

 * Standard Linux build tools (make, gcc, curl, tar, gunzip)

Unix / Linux / Mac OS X
-----------------------

Simply run `./install.sh` to install into the current directory.

Windows
-------

There's no automated install script just yet, but you can get it running by following these steps:

 1. Make sure you have sufficient build tools installed to compile C code (e.g: Visual Studio, etc).
 2. Download, build, and install the [MaxMind GeoIP C API][1].
 3. Compile this project's source, located in the **src** directory.
 4. Download and install the free [MaxMind GeoLite City database][2].

 [1]: http://www.maxmind.com/app/c
 [2]: http://www.maxmind.com/app/installation?city=1
