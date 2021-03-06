#!/bin/bash -ex
rm -rf .testenv
virtualenv .testenv
source .testenv/bin/activate
rm -rf dist
python setup.py sdist

if [ "$(uname)" == "Dawrin" ]; then
  #brew install gmp
  env "CFLAGS=-I/usr/local/include -L/usr/local/lib" pip install ./dist/ansible-modules-hashivault-*.tar.gz
else
  pip install ./dist/ansible-modules-hashivault-*.tar.gz
fi

# execute tests only if we have docker installed
if [ $(which docker 2> /dev/null) ]; then
  cd functional
  ./run.sh
  cd ..
fi

rm -rf .testenv
