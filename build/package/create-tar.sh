#!/bin/bash

COMMAND=$1
OS=$2
VERSION=$3

OUTPUT_NAME=nri-docker-${OS}-${VERSION}
TEMPDIR=`mktemp -d`
BUILD_DIR=${TEMPDIR}/${OUTPUT_NAME}

[ -f "${OUTPUT_NAME}.tar.gz" ] && rm -rf ${OUTPUT_NAME}.tar.gz
mkdir -p ${BUILD_DIR}

cp ./bin/${OS}/* ${BUILD_DIR}/
cp ./README.md ${BUILD_DIR}/
[ -f "./scripts/install_${OS}.sh" ] && cp ./scripts/install_${OS}.sh ${BUILD_DIR}/
[ -f "./scripts/install_${OS}.bat" ] && cp ./scripts/install_${OS}.bat ${BUILD_DIR}/
cp ./configs/nri-docker-config.yml ${BUILD_DIR}/
cp ./configs/nri-docker-def-${OS}.yml ${BUILD_DIR}/${COMMAND}-definition.yml
cp ./configs/Dockerfile-${OS} ${BUILD_DIR}/Dockerfile

# Create the gzip
tar -C ${TEMPDIR} -czf ${OUTPUT_NAME}.tar.gz ${OUTPUT_NAME}/

# Cleanup
rm -rf ${BUILD_DIR}

