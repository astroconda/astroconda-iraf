# Install aXe binaries into STSDAS in the same way as the Ureka pkg-install:

cd ccc

./configure --prefix="$PREFIX" --with-cfitsio-prefix="$PREFIX" \
            --with-wcstools-prefix="$PREFIX/lib" --build=x86 \
            --with-gsl-prefix="$PREFIX" || exit 1

make || exit 1

# Creating a dummy STSDAS directory avoids having IRAF as a heavyweight build
# dependency when it's not needed (at the cost of this script having to know
# the IRAF directory structure in the env, but that's not likely to change):
stdir=$PREFIX/iraf_extern/stsdas
mkdir -p "$stdir/bin" && cp -p bin/* "$stdir/bin/" || exit 1

