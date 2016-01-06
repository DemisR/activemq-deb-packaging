#!/bin/bash

set -e
set -u
name=activemq
version=5.13.0
package_version="-1"
description="Apache ActiveMQ is a message broker built around Java Message Service (JMS) API : allow sending messages between two or more clients in a loosely coupled, reliable, and asynchronous way."
url="http://activemq.apache.org/"
arch="all"
section="misc"
license="Apache Software License 2.0"
bin_package="apache-activemq-${version}-bin.tar.gz"
bin_download_url="http://apache.belnet.be/activemq/${version}/${bin_package}"
origdir="$(pwd)"

#_ MAIN _#
rm -rf ${name}*.deb
if [[ ! -f "${bin_package}" ]]; then
  wget -c ${bin_download_url}
fi
mkdir -p tmp && pushd tmp
rm -rf activemq
mkdir -p activemq
cd activemq
mkdir -p build/usr/local/activemq
mkdir -p build/etc/default
mkdir -p build/etc/init.d
mkdir -p build/etc/activemq
mkdir -p build/var/log/activemq


cp ${origdir}/files/config/default/activemq.default build/etc/default/activemq
# cp ${origdir}/files/config/init/activemq.init.d build/etc/init.d/activemq

# Updated to use the Binary package

tar zxf ${origdir}/${bin_package}
cd apache-activemq-${version}

# Config files
mv conf/* ../build/etc/activemq
cp ${origdir}/files/config/etc/activemq.xml.dist ../build/etc/activemq
cp ${origdir}/files/config/etc/log4j.properties ../build/etc/activemq
mv * ../build/usr/local/activemq/
rmdir ../build/usr/local/activemq/conf
if [ -d "../build/usr/local/activemq/log" ]; then
  rmdir ../build/usr/local/activemq/log
fi
cd ../build
pushd usr/local/activemq
popd

fpm -t deb \
    -n ${name} \
    -v ${version}${package_version} \
    --description "${description}" \
    --url="{$url}" \
    -a ${arch} \
    --category ${section} \
    --vendor "" \
    --license "${license}" \
    --config-files etc/activemq \
    -m "${USER}@localhost" \
    --prefix=/ \
    -d oracle-j2sdk1.8 \
    --after-install ${origdir}/files/build/postinst \
    --after-remove ${origdir}/files/build/postrm \
    -s dir \
    -- .
mv activemq*.deb ${origdir}
popd
