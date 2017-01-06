# Drop extraneous conda-set environment variables
unset ARCH CFLAGS CXXFLAGS LDFLAGS MACOSX_DEPLOYMENT_TARGET

# Complement build script
export TERM=xterm

# Tell the build script where IRAF is (& it will then set up its environment)
export iraf=$PREFIX/iraf/

# Execute build
printenv   > build_log 2>&1
./build 32 >> build_log 2>&1 || exit 1

# Copy files into PREFIX (including obligatory licensing info.)
mkdir -p "$PREFIX"/{bin,include,lib,share} || exit 1
./install.bin "$PREFIX" || exit 1
./install.lib "$PREFIX" || exit 1
./install.man "$PREFIX/share" || exit 1
./install.doc "$PREFIX/share" || exit 1

