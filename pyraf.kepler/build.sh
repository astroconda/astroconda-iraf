# Configure the environment for IRAF, since conda build appears not to do
# "source activate" after installing dependencies (this would instead need to
# eval $PREFIX/iraf/unix/hlib/setup directly if "--level" needs specifying):
. setup_iraf.sh

# Build from source in envs/_build (using build script from astroconda-utils):
ac_build_iraf_pkg

