#!/bin/sh
cd $(dirname $0)

cd ../complete

./mvnw clean package
ret=$?
if [ $ret -ne 0 ]; then
    exit $ret
fi

java -jar target/gs-maven-0.1.0.jar | tail -1 > target/actual.txt

echo "Let's look at the actual results: `cat target/actual.txt`"
echo "And compare it to: `cat ../test/expected.txt`"

if diff -w ../test/expected.txt target/actual.txt
    then
        echo SUCCESS
        let ret=0
    else
        echo FAIL
        let ret=255
        exit $ret
fi
rm -rf target

cd ../initial

./mvnw clean compile
ret=$?
if [ $ret -ne 0 ]; then
    exit $ret
fi
rm -rf target

exit
