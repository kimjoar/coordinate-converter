require File.join(File.dirname(__FILE__), '..', 'lib', 'coordinates')

describe Coordinates do
  describe "#utm_to_lat_long" do
    it "should return a hash with keys lat and long" do
      ll = Coordinates.utm_to_lat_long("WGS-84", 6688940, 219165, "33N")
      ll.should be_an Hash
      ll.has_key?(:lat).should be_true
      ll.has_key?(:long).should be_true
    end

    it "should return a correct lat long for the reference ellipsoid WGS-84 in the zone 33N" do
      coords = Coordinates.utm_to_lat_long("WGS-84", 6688940, 219165, "33N")
      
      coords[:lat].should be_close(60.2399303597183, 0.00000005)
      coords[:long].should be_close(9.92496237547609, 0.00000005)
    end
  end
end