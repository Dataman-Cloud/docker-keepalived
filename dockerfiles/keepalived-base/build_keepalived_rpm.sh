#!/bin/bash
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir

set -e
version=1.3.5

rm -rf keepalived-$version.tar.gz keepalived-$version
wget http://www.keepalived.org/software/keepalived-$version.tar.gz
tar xzvf keepalived-$version.tar.gz
mv keepalived-$version.tar.gz keepalived-$version
docker run --rm -e VERBOSE="-x" -v $base_dir/keepalived-$version:/src --workdir=/src --entrypoint="./configure" demoregistry.dataman-inc.com/library/centos7-rpmbuild --disable-dynamic-linking
docker run --rm -e VERBOSE="-x" -v $base_dir/keepalived-$version:/src --workdir=/src demoregistry.dataman-inc.com/library/centos7-rpmbuild keepalived.spec

rm -f *.rpm
cp keepalived-$version/RPMS/x86_64/*.rpm .
cp keepalived-$version/SRPMS/*.rpm .
rm -rf keepalived-$version
