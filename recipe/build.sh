#!/bin/bash

if [[ ${target_platform} == "linux-64" ]] || [[ ${target_platform} == "linux-aarch64" ]]; then
  sed -i 's/std::ios::streampos/std::streampos/g' src/View.cpp
  ./waf configure build install \
      --prefix=${PREFIX} \
      --bindir=${PREFIX}/bin \
      --libdir=${PREFIX}/lib \
      --jobs=${CPU_COUNT} \
      CFLAGS="${CFLAGS} -I${PREFIX}/include -I${PREFIX}/include/boost" \
      LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
elif [[ ${target_platform} == "osx-64" ]]; then
  sed -i 's/std::auto_ptr/std::unique_ptr/g' db/include/db/Transaction.hpp
  sed -i 's/std::auto_ptr/std::unique_ptr/g' db/include/db/Connection.hpp
  sed -i 's/std::auto_ptr/std::unique_ptr/g' db/include/db/SQLStatement.hpp
  ./waf configure build install \
      --prefix=${PREFIX} \
      --bindir=${PREFIX}/bin \
      --libdir=${PREFIX}/lib \
      --jobs=${CPU_COUNT} \
      CFLAGS="${CFLAGS} -I${PREFIX}/include -I${PREFIX}/include/boost" \
      LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
fi
