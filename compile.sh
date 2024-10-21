#!/bin/sh
envsubst <android-$ARCH >build-crossfile
meson setup "build-android" \
	--prefix=/tmp/virglrenderer \
	--cross-file "build-crossfile" \
	-Dplatforms=egl \
	-Dcheck-gl-errors=false \
	-Ddefault_library=static
ninja -C "build-android" install
