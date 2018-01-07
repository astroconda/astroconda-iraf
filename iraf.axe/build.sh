# Install aXe binaries into STSDAS in the same way as the Ureka pkg-install.
# This must be built on CentOS >=6, for compatibility with the cfitsio build.

set -e

# Get the target stsdas/bin.$IRAFARCH installation path from IRAF.
# The aXe build does not actually rely on IRAF apart from this.
. setup_iraf.sh
rm -rf irafdir
mkdir irafdir
cd irafdir
echo xterm | mkiraf > tmp
touch .hushiraf
cl > tmp << ARF
cd stsdas
cd bin
pwd -P
logout
ARF
stbindir=$(sed -Ee 's|e?cl>[ \t]*||g' tmp)
stdir=$(dirname "$stbindir")
cd ..

if ! echo "$stbindir" | grep -q 'stsdas/bin'; then
    echo "Failed to determine stsdas/bin path from IRAF" >&2
    exit 1
fi

# I'd have thought conda-build would take care of this but it appears not to:
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/lib"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$PREFIX/lib"

# Compilation of the old GSL version fails on clang without allowing for some
# deprecated C usage, as when building IRAF:
export CFLAGS="$CFLAGS -Wno-return-type"

echo "Build static GSL (old version needed by aXe)"

# Put static GSL in a temporary location, because we don't need to distribute
# its headers & documentation, which might conflict with the gsl conda package,
# plus installing its docs to $PREFIX/info causes conda-build 3.0 to fail.
cd gsl
./configure --prefix="${SRC_DIR}/gsl_build" --disable-shared --enable-static \
	    --build=x86
make
make install
# here the GSL COPYRIGHT is covered by aXe's own GPL notice

echo "Build aXe"

cd ../aXe/ccc
./configure --prefix="$PREFIX" --with-cfitsio-prefix="$PREFIX" \
            --with-wcstools-prefix="$PREFIX/lib" --build=x86 \
            --with-gsl-prefix="${SRC_DIR}/gsl_build"
make

echo "Install aXe into $stbindir/"
cp -p bin/* "$stbindir/"

# Install obligatory licensing information (best kept in pkg with binaries):
cp -p "$RECIPE_DIR/copyright.aXe" "$stdir/"

# Newer versions of the Python files in iraf/acesrc are also required, as of
# 2017, but those have been updated in the STSDAS 3.18 source rather than here,
# as they live in STSDAS from the outset.

