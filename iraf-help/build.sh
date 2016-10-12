# Configure the environment for IRAF, since conda build appears not to do
# "source activate" after installing dependencies (this would instead need to
# eval $PREFIX/iraf/unix/hlib/setup directly if "--level" needs specifying):
. setup_iraf.sh

logname=help_log

make_iraf_help iraf > $logname 2>&1
make_iraf_help noao >> $logname 2>&1
make_iraf_help color >> $logname 2>&1
make_iraf_help vol >> $logname 2>&1

cp -p $logname "$PREFIX/iraf/"

