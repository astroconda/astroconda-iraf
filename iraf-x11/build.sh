# Drop extraneous conda-set environment variables
unset ARCH CFLAGS CXXFLAGS LDFLAGS MACOSX_DEPLOYMENT_TARGET

# Complement build script
export TERM=xterm

# Tell the build script where IRAF is (& it will then set up its environment)
export iraf=$PREFIX/iraf/

# Execute build
printenv   > build_log 2>&1
./build 32 >> build_log 2>&1

# Copy files into PREFIX
mkdir -p $PREFIX/{bin,include,lib,share}
./install.bin $PREFIX
./install.lib $PREFIX
./install.man $PREFIX/share

