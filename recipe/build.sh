#!/bin/bash

if [[ ${target_platform} == "linux-64" ]] || [[ ${target_platform} == "linux-aarch64" ]]; then
  sed -i 's/std::ios::streampos/std::streampos/g' src/View.cpp
elif [[ ${target_platform} == "osx-64" ]]; then
  sed -i '' "s/std::ios::streampos/std::streampos/g" src/View.cpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" db/include/db/Transaction.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" db/include/db/Connection.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" db/include/db/SQLStatement.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" genfile/include/genfile/bgen/IndexQuery.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" genfile/include/genfile/bgen/View.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" appcontext/include/appcontext/OptionProcessor.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" appcontext/include/appcontext/CmdLineUIContext.hpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" appcontext/src/ApplicationContext.cpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" apps/bgenix.cpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" apps/cat-bgen.cpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" apps/edit-bgen.cpp
  sed -i '' "s/std::auto_ptr/std::unique_ptr/g" test/unit/catch.hpp
fi

./waf configure build install \
      --prefix=${PREFIX} \
      --bindir=${PREFIX}/bin \
      --libdir=${PREFIX}/lib \
      --jobs=${CPU_COUNT} \
      CFLAGS="${CFLAGS} -I${PREFIX}/include -I${PREFIX}/include/boost" \
      LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
