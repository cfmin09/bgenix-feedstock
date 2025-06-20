#!/bin/bash

if [[ ${target_platform} == "linux-64" ]] || [[ ${target_platform} == "linux-aarch64" ]]; then
  sed -i 's/std::ios::streampos/std::streampos/g' src/View.cpp
elif [[ ${target_platform} == "osx-64" ]]; then
  sed -i '' "s/std::ios::streampos/std::streampos/g" src/View.cpp
  sed -i '' "s/cxxflags=\[\]/cxxflags=\['-std=c++11'\]/g" db/wscript
fi

./waf configure build install \
      --prefix=${PREFIX} \
      --bindir=${PREFIX}/bin \
      --libdir=${PREFIX}/lib \
      --jobs=${CPU_COUNT} \
      CFLAGS="${CFLAGS} -I${PREFIX}/include -I${PREFIX}/include/boost" \
      LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
