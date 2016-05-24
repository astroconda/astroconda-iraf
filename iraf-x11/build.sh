# Drop extraneous conda-set environment variables
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS

# Complement build script
# ("UR_IRAFUSER" MUST BE SET OR BUILD WILL FAIL)
export UR_IRAFUSER=1
export TERM=xterm


# Copy working directory into PREFIX
export iraf=$PREFIX/iraf/

# Execute build
printenv
./build 32

mkdir -p $PREFIX/{bin,include,lib,share}
./install.bin $PREFIX
./install.lib $PREFIX
./install.man $PREFIX/share

