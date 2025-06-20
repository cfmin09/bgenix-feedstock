#!/bin/bash

if [[ ${target_platform} == "linux-64" ]] || [[ ${target_platform} == "linux-aarch64" ]]; then
  sed -i "s/\[[[:space:]]*'-O3'[[:space:]]*\]/['-O3', '-std=c++11']/g" wscript
elif [[ ${target_platform} == "osx-64" ]]; then
  sed -i '' "s/\[[[:space:]]*'-O3'[[:space:]]*\]/['-O3', '-std=c++11']/g" wscript
fi

./waf configure build install \
      --prefix=${PREFIX} \
      --bindir=${PREFIX}/bin \
      --libdir=${PREFIX}/lib \
      --jobs=${CPU_COUNT} \
      CFLAGS="${CFLAGS} -I${PREFIX}/include -I${PREFIX}/include/boost" \
      LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
