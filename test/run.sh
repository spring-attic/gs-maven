#!/bin/sh
cd $(dirname $0)

cd ../complete

mvn clean package
ret=$?
if [ $ret -ne 0 ]; then
exit $ret
fi
rm -rf target

cd ../initial

mvn clean package
ret=$?
if [ $ret -ne 0 ]; then
exit $ret
fi
rm -rf target

exit
