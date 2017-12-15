# Install aXe binaries into STSDAS in the same way as the Ureka pkg-install.
# This must be built on CentOS >=6, for compatibility with the cfitsio build.

# I'd have thought conda-build would take care of this but it appears not to:
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/lib"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$PREFIX/lib"

set -e

# Creating a dummy STSDAS directory as the install target avoids having IRAF
# as a heavyweight build dependency when it's not needed (at the cost of this
# script having to know the IRAF directory structure in the env, but that's
# not likely to change):
stdir=$PREFIX/iraf_extern/stsdas
mkdir -p "$stdir/bin"

echo "Build static GSL (old version needed by aXe)"

cd gsl
./configure --prefix="$PREFIX" --disable-shared --enable-static --build=x86
make
make install
# here the GSL COPYRIGHT is covered by aXe's own GPL notice

echo "Build aXe"

cd ../aXe/ccc
./configure --prefix="$PREFIX" --with-cfitsio-prefix="$PREFIX" \
            --with-wcstools-prefix="$PREFIX/lib" --build=x86 \
            --with-gsl-prefix="$PREFIX"
make

echo "Install aXe into STSDAS path"
cp -p bin/* "$stdir/bin/"

# Install obligatory licensing information (best kept in pkg with binaries):
cp -p "$RECIPE_DIR/copyright.aXe" "$stdir/"

# Newer versions of the Python files in iraf/acesrc are also required, as of
# 2017, but those have been updated in the STSDAS 3.18 source rather than here,
# as they live in STSDAS from the outset.

