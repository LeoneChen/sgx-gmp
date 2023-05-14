#!/bin/bash
set -e

ROOT_DIR=$(realpath -s $(dirname $0))

if [[ $1 == 'debug' ]]; then
    DEBUG_FLAG=" -O0 -g"
else
    DEBUG_FLAG=" -O2"
fi

mkdir -p build

cd build
../configure --prefix=${ROOT_DIR}/install --enable-assembly --disable-shared --enable-static --with-pic --enable-sgx CC=clang-13 CXX=clang++-13 CFLAGS="-fno-discard-value-names -flto ${DEBUG_FLAG}" CXXFLAGS="-fno-discard-value-names -flto ${DEBUG_FLAG}"

make -j$(nproc)
make install
