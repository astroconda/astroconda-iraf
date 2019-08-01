cd local_calibs

$PYTHON setup.py install --single-version-externally-managed --record=record.txt || exit 1

# # According to conda-forge #528 and the conda-forge docs, this seems to be a
# # newer way of doing the above (also need to add "pip" to build or host deps.
# # in meta.yaml), but it's not actually working for me with conda-build
# # 3.10.5; stick to the way AstroConda does it for now.
# $PYTHON -m pip install --no-deps --ignore-installed -vv . || exit 1

mkdir -p ${PREFIX}/share/gemini_calmgr/
cp -p LICENSE ${PREFIX}/share/gemini_calmgr/ || exit 1

