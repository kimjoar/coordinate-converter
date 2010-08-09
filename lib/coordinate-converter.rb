module Coordinates
  def self.utm_to_lat_long(reference_ellipsoid, northing, easting, zone)    
    a  = equitorial_radius(reference_ellipsoid)
    ecc_squared = eccentricity_squared(reference_ellipsoid)
    
    e1 = (1 - Math.sqrt(1 - ecc_squared)) / (1 + Math.sqrt(1 - ecc_squared))
    
    x = easting - 500000.0 
    y = northing
    
    zone_letter = zone[-1].chr
    zone_number = zone[0..-2].to_i
    if zone_letter >= 'S'
      y -= 10000000.0   
    end
    
    long_origin = (zone_number - 1) * 6 - 180 + 3
    ecc_prime_squared = (ecc_squared) / (1 - ecc_squared)
    
    k0 = 0.9996
    m  = y / k0
    mu = m / (a * (1 - ecc_squared / 4 - 3 * ecc_squared * ecc_squared / 64 - 5 \
       * ecc_squared * ecc_squared * ecc_squared / 256))
    
    phi1_rad = (mu + (3 * e1 / 2 - 27 * e1 * e1 * e1 / 32) * Math.sin(2 * mu) \
                   + (21 * e1 * e1 / 16 - 55 * e1 * e1 * e1 * e1 / 32) \
                   * Math.sin(4 * mu) + (151 * e1 * e1 * e1 / 96) \
                   * Math.sin(6 * mu))
    
    n1 = a / Math.sqrt(1 - ecc_squared * Math.sin(phi1_rad) * Math.sin(phi1_rad))
    t1 = Math.tan(phi1_rad) * Math.tan(phi1_rad)
    c1 = ecc_prime_squared * Math.cos(phi1_rad) * Math.cos(phi1_rad)
    r1 = a * (1 - ecc_squared) / (1 - ecc_squared * Math.sin(phi1_rad) * Math.sin(phi1_rad))**1.5
    d  = x / (n1 * k0)

    lat = phi1_rad - (n1 * Math.tan(phi1_rad) / r1) * (d * d / 2 - (5 + 3 * t1 \
        + 10 * c1 - 4 * c1**2 - 9 * ecc_prime_squared) * d**4 / 24 + (61 + 90 \
        * t1 + 298 * c1 + 45 * t1**2 - 252 * ecc_prime_squared - 3 * c1**2) \
        * d**6 / 720)
    lat = lat * RAD_TO_DEG

    long = (d - (1 + 2 * t1 + c1) * d * d * d / 6 + (5 - 2 * c1 + 28 \
         * t1 - 3 * c1 * c1 + 8 * ecc_prime_squared + 24 * t1 * t1) \
         * d * d * d * d * d / 120) / Math.cos(phi1_rad)

    long = long_origin + long * RAD_TO_DEG

    { :lat => lat, :long => long }
  end
  
  private 
  
  def self.equitorial_radius(ellipsoid)
    ELLIPSOID[ellipsoid].first
  end
  
  def self.eccentricity_squared(ellipsoid)
    ELLIPSOID[ellipsoid].last
  end
  
  ELLIPSOID = {
    "Airy"                   => [6377563, 0.00667054],
    "Australian National"    => [6378160, 0.006694542],
    "Bessel 1841"            => [6377397, 0.006674372],
    "Bessel 1841 (Nambia)"   => [6377484, 0.006674372],
    "Clarke 1866"            => [6378206, 0.006768658],
    "Clarke 1880"            => [6378249, 0.006803511],
    "Everest"                => [6377276, 0.006637847],
    "Fischer 1960 (Mercury)" => [6378166, 0.006693422],
    "Fischer 1968"           => [6378150, 0.006693422],
    "GRS 1967"               => [6378160, 0.006694605],
    "GRS 1980"               => [6378137, 0.00669438],
    "Helmert 1906"           => [6378200, 0.006693422],
    "Hough"                  => [6378270, 0.00672267],
    "International"          => [6378388, 0.00672267],
    "Krassovsky"             => [6378245, 0.006693422],
    "Modified Airy"          => [6377340, 0.00667054],
    "Modified Everest"       => [6377304, 0.006637847],
    "Modified Fischer 1960"  => [6378155, 0.006693422],
    "South American 1969"    => [6378160, 0.006694542],
    "WGS 60"                 => [6378165, 0.006693422],
    "WGS 66"                 => [6378145, 0.006694542],
    "WGS-72"                 => [6378135, 0.006694318],
    "WGS-84"                 => [6378137, 0.00669438]
  }
  
  RAD_TO_DEG = 180.0 / Math::PI
end