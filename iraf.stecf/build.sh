name=stecf

# Configure the environment for IRAF, since conda build appears not to do
# "source activate" after installing dependencies (this would instead need to
# eval $PREFIX/iraf/unix/hlib/setup directly if "--level" needs specifying):
. setup_iraf.sh

# Copy list of proprietary files to remove, from ../stsci_iraf/release_tools
# (conda build stops if this fails, due to "set -e"):
sed -ne "s|^$name/||p" release_tools/numrec_list.txt > $name/numrec_list.txt

# Change to the package subdir (special case for STScI IRAF):
cd $name

# Build from source in envs/_build (using build script from astroconda-utils):
ac_build_iraf_pkg

