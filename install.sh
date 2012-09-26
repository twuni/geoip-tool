#!/bin/sh

GEOIP_API_C="http://www.maxmind.com/download/geoip/api/c/GeoIP.tar.gz"
GEOIP_DB_CITY="http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"

base_dir="`pwd`"
build_dir="$base_dir/build"

clean() {
  for dir in bin build etc include lib share; do
    rm -fR "$base_dir/$dir"
  done
}

clean_build_dir() {
  echo "Cleaning up build directory..."
  rm -fR "$build_dir"
}

build() {
  clean
  mkdir -p "$build_dir"
  download_library
  install_library
  download_city_database
  clean_build_dir
  compile
}

compile() {
  echo "Compiling geoip.c..."
  gcc -Wall -Iinclude -L"$base_dir/lib" -lGeoIP -o "$base_dir/bin/geoip" "$base_dir/src/geoip.c"
}

install_library() {

  cd "$build_dir"/GeoIP* || die "Unexpected file format."

  echo "Building and installing GeoIP C API..."
  ./configure --prefix="$base_dir" || die "Failed to configure GeoIP C API."
  make || die "Failed to build GeoIP C API."
  make install || die "Failed to install GeoIP C API."

}

download_library() {

  cd "$build_dir"

  echo "Downloading GeoIP C API source from $GEOIP_API_C..."
  curl -s "$GEOIP_API_C" > ___GeoIP.tar.gz || die "Download failed."
  tar zvxf ___GeoIP.tar.gz || die "Unable to extract file."

}

download_city_database() {

  cd "$build_dir"

  echo "Downloading GeoIP Lite city database from $GEOIP_DB_CITY..."
  curl -s "$GEOIP_DB_CITY" > GeoIPCity.dat.gz || die "Download failed."
  gunzip GeoIPCity.dat.gz || die "Unable to extract file."
  mv *.dat "$base_dir/share/GeoIP/GeoIPCity.dat" || die "Unexpected file format."

}

die() {
  echo "$*"
  exit 1
}

test -d "$base_dir/bin" || build
test -d "$base_dir/share" || build
test -d "$base_dir/include" || build
test -d "$base_dir/lib" || build

echo "Successfully installed!"
