set -x

# Drop extraneous conda-set environment variables
unset ARCH CFLAGS CXXFLAGS LDFLAGS MACOSX_DEPLOYMENT_TARGET

# Complement build script
export TERM=xterm

# Execute build
printenv
if ! ./build 32; then
    echo "The main IRAF build failed" 2>&1
    exit 1
fi

echo

# Install into PREFIX
if ! ./install $PREFIX; then
    echo "IRAF installation into $PREFIX failed" 2>&1
    exit 1
fi

# "Register" the IRAF environment setup with conda activate:
mkdir -p $PREFIX/etc/conda/{activate.d,deactivate.d}

echo '
if [ -n "$CONDA_PREFIX" ]; then
    source $CONDA_PREFIX/bin/setup_iraf.sh
else
    source $CONDA_ENV_PATH/bin/setup_iraf.sh
fi
' > $PREFIX/etc/conda/activate.d/iraf.sh
chmod 755 $PREFIX/etc/conda/activate.d/iraf.sh

echo '
if [ -n "$CONDA_PREFIX" ]; then
    source $CONDA_PREFIX/bin/forget_iraf.sh
else
    source $CONDA_ENV_PATH/bin/forget_iraf.sh
fi
' > $PREFIX/etc/conda/deactivate.d/iraf.sh
chmod 755 $PREFIX/etc/conda/deactivate.d/iraf.sh

