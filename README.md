Converting UTM to Latitude and Longitude
========================================

Install
-------

    gem install coordinate-converter

Example
-------

    Coordinates.utm_to_lat_long("WGS-84", 6688940, 219165, "33N")
    # => {:lat => 60.2399303597183, :long => 9.92496237547609}

Parameters are specified in the following order:

* reference_ellipsoid
* northing
* easting
* zone

Supported ellipsoids
--------------------

* Airy
* Australian National
* Bessel 1841
* Bessel 1841 (Nambia)
* Clarke 1866
* Clarke 1880
* Everest
* Fischer 1960 (Mercury)
* Fischer 1968
* GRS 1967
* GRS 1980
* Helmert 1906
* Hough
* International
* Krassovsky
* Modified Airy
* Modified Everest
* Modified Fischer 1960
* South American 1969
* WGS 60
* WGS 66
* WGS-72
* WGS-84