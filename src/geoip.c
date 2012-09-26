#include <stdio.h>
#include <GeoIP.h>
#include <GeoIPCity.h>

int main( int argc, char* argv[] ) {

  GeoIP* records;
  int i;
  char* ip;
  GeoIPRecord* record;

  records = GeoIP_open_type( GEOIP_CITY_EDITION_REV1, GEOIP_STANDARD );

  for( i = 1; i < argc; i++ ) {

    ip = argv[i];

    record = GeoIP_record_by_addr( records, ip );

    printf( "%s\t%s, %s\t%s\t(%3.6f,%3.6f)\n", ip, record->city, record->region, record->country_name, record->latitude, record->longitude );

  }

  return 0;

}
