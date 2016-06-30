# Drop extraneous conda-set environment variables
unset ARCH CFLAGS CXXFLAGS LDFLAGS

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

echo "source \$CONDA_ENV_PATH/bin/setup_iraf.sh" > \
    $PREFIX/etc/conda/activate.d/iraf.sh
chmod 755 $PREFIX/etc/conda/activate.d/iraf.sh

echo "source \$CONDA_ENV_PATH/bin/forget_iraf.sh" > \
    $PREFIX/etc/conda/deactivate.d/iraf.sh
chmod 755 $PREFIX/etc/conda/deactivate.d/iraf.sh


# JT: the following are some commented bits from Joe's original build.sh that I
# think are no longer needed but have no replacement in the new install script.

#cd $iraf

#UR_BUILTIN=/Users/Shared/ureka.iraf/ur_work/iraf
#find . -lname "$UR_BUILTIN/*" \
#-exec sh -c 'echo Re-linking builtin paths "$0" ;\
#ln -snf "$(readlink "$0" \
#| sed -e "s|$UR_BUILTIN|../..|" -e "s|/as/|/as.$IRAFARCH/|")" "$0"' {} \;
#
#find . -lname '/iraf/iraf/*' \
#-exec sh -c 'echo Re-linking "$0" ;\
#ln -snf "$(readlink "$0" \
#| sed -e "s|/iraf/iraf|../..|" -e "s|/as/|/as.$IRAFARCH/|")" "$0"' {} \;

#echo "Removing dead symlinks..."
#find $iraf $iraf/../variants -type l | xargs -n 1 -I'{}' \
#sh -c 'file {} | grep broken | cut -f 1 -d :' | xargs rm -f

