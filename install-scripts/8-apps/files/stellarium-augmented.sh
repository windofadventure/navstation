#!/bin/bash

# hack to control stellarium azimuth by true north heading from signalK

MESA_GL_VERSION_OVERRIDE=3.0 MESA_GLSL_VERSION_OVERRIDE=130 stellarium "$@"  &
sleep 12

i=0
while [[ -n "$(pidof stellarium)" ]]
do
  # magnetic variation
  if [[ $((i%100)) == 0 ]]; then
    MV=$(curl -s http://localhost:3000/signalk/v1/api/vessels/self/navigation/magneticVariation/value)
    i=0
  fi
  # magnetic heading
  MH=$(curl -s http://localhost:3000/signalk/v1/api/vessels/self/navigation/headingMagnetic/value)
  if [ -n "$MH" ] && [ -n "$MV" ]; then
    # true heading
    HT=$(echo $MH + $MV - 3.1415926535 | bc)
    # control stellarium azimuth
    curl -X POST -d "az=$HT" 'http://localhost:8090/api/main/view'
  fi
  # control stellarium location
  POS="$(curl -s http://localhost:3000/signalk/v1/api/vessels/self/navigation/position/ | jq -M -jr '"latitude=",.value.latitude,"&longitude=",.value.longitude')"
  if [ -n "$POS" ] && [ "latitude=null&longitude=null" != "$POS" ]; then
    curl -X POST -d "altitude=2&${POS}&name=Current" 'http://localhost:8090/api/location/setlocationfields'
  fi
  sleep 3
  i=$((i+1))
done
