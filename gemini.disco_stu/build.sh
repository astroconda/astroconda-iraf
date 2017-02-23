(cd doc/ && make html && make latexpdf) || exit 1

python setup.py install || exit 1

cp -p LICENSE ${PREFIX}/share/disco_stu/

