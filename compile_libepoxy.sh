#!/bin/bash
if [ ! -d ./libepoxy ] ; then
   git clone --depth 1 https://github.com/anholt/libepoxy/
   pushd libepoxy
else
   pushd libepoxy
   git fetch origin
   git pull
fi

envsubst <../android-$ARCH >build-crossfile
meson setup "build-android" \
	--prefix=$PWD/epoxyprefix \
	--cross-file "build-crossfile" \
	-Dglx=no \
	-Dx11=false \
	-Degl=yes \
	-Dtests=false \
	-Ddefault_library=static
ninja -C "build-android" install
cp $PWD/epoxyprefix/lib/pkgconfig/epoxy.pc ../epoxy.pc
popd

