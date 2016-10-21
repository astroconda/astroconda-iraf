# Copy some 32-bit X11 & curses libs from the OS for ecl & X11IRAF

# These libs don't change much but it's possible that this list might need
# generalizing later, to pick up whatever major version is actually used
# on any given build machine:
libs="libXmu.so.6 libXt.so.6 libSM.so.6 libICE.so.6 libXext.so.6 libX11.so.6 \
      libXau.so.6 libXdmcp.so.6 libXfixes.so.3 libXrender.so.1"

oslib="/usr/lib"                # CentOS keeps 32-bit libs here
osdoc="/usr/share/doc"          # CentOS keeps copyright notices etc. here
destlib="$PREFIX/lib32"
destdoc="$PREFIX/share/doc"

mkdir -p "$destlib" "$destdoc"

# Copy each binary directly from the OS:
for lib in $libs; do
    cp -pf "${oslib}/${lib}" "${destlib}/"
done

(
    # Include copyright notices, as required by the licences:
    cd "$destdoc"
    mkdir X11 ncurses

    xdoc=`ls "$osdoc"/libX11-?.*/COPYING`         # CentOS 5 location
    if [ ! -f "$xdoc" ]; then
        xdoc=`ls "$osdoc"/xorg-x11-server-common-?.*/COPYING`  # CentOS 6
    fi

    cp -pf "$xdoc" X11/
    cp -pf "$osdoc"/ncurses-?.*/README ncurses/
)
