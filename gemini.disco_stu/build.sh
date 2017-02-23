(cd doc/ && make html && make latexpdf) || exit 1

python setup.py install

