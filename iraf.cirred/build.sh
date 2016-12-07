# Configure the environment for IRAF, since conda build appears not to do
# "source activate" after installing dependencies (this would instead need to
# eval $PREFIX/iraf/unix/hlib/setup directly if "--level" needs specifying):
. setup_iraf.sh

# Copy the cfitsio build dependency from IRAF:
cp -p ${iraf}/bin/libcfitsio.a libcfitsio32.a || exit 1  # picked up by mkpkg

# Build from source in envs/_build (using build script from astroconda-utils):
ac_build_iraf_pkg

