set -e

# Install as a Python package:
$PYTHON -m pip install . --no-deps --ignore-installed --no-cache-dir -v

# Documentation:
mkdir -p ${PREFIX}/share/pyfu && cp -p README LICENSE ${PREFIX}/share/pyfu/

# Also set up as an IRAF package, just by linking to the Python version from
# the iraf_extern directory (it doesn't need building & installing like an SPP
# package but we use the defs from astroconda-iraf-helpers to put things in
# the right places):
. ac_iraf_defs

ext_path="${PREFIX}/${extern_dir}"
mkdir -p "$ext_path"

(cd "$ext_path" && ln -s ${SP_DIR}/pyfu .)

# Copy some files for IRAF that don't get installed by setup.py:
cp -p "${RECIPE_DIR}/${pkg_extpkg}" "${ext_path}/pyfu/"
cp -p pyfu/pyfu.cl pyfu/*.par "${ext_path}/pyfu/"

