set -e

# Build the package in the usual way:
$PYTHON -m pip install . --no-deps --ignore-installed --no-cache-dir -vv

# Build the Sphinx documentation with our purpose-built LaTeX package:
docs="astrodata/doc/ad_CheatSheet astrodata/doc/ad_ProgManual \
      astrodata/doc/ad_UserManual recipe_system/doc/rs_ProgManual \
      recipe_system/doc/rs_UsersManual geminidr/doc/progmanuals/notes4manual \
      geminidr/doc/tutorials/F2Img-DRTutorial \
      geminidr/doc/tutorials/GSAOIImg-DRTutorial \
      geminidr/doc/tutorials/NIRIImg-DRTutorial \
      doc/DRAGONS gempy/doc/mosaic"

# Doc build to be completed here. Need to add a doc build step / script to
# DRAGONS itself, to keep things modular and allow building everything without
# the conda recipe.

# cd doc/ && make html && make latexpdf

# License files now get copied into the package as specified in meta.yaml, but
# not to the env where users can easily find them, so continue copying here too:
mkdir -p ${PREFIX}/share/dragons/
cp -p LICENSE ${PREFIX}/share/dragons/
cp -pR extern_licenses ${PREFIX}/share/dragons/

