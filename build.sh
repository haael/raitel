#!/bin/sh

# create root directory
rm -rf root
mkdir root
mkdir root/var
mkdir root/bin
mkdir root/lib
cp -r etc root/
cp start.sh root/
cp encode_eip55.js root/bin

# install node modules
(
cd root/lib
npm install eip55
)

# install geth
(
cd geth
make geth
cp build/bin/geth ../root/bin/
)

# install raiden
(
cd raiden
python3 ./setup.py install --prefix=../root
)

