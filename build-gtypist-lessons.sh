#!/bin/bash

# License: GPL v3
# Copyright: 2012 maizy.ru"
# Author: Nikita Kovaliov <nikita@maizy.ru>
# Version: 0.1

# Generate gtypist lessons

SCRIPT_PATH=$(cd ${0%/*} && echo $PWD/${0##*/})
PROJECT_ROOT=`dirname ${SCRIPT_PATH}`
LESSONS_ROOT="${PROJECT_ROOT}"
BUILD_DIR="${PROJECT_ROOT}/builds"

LESSONS=`ls ${LESSONS_ROOT}/*.ktouch.xml`

TOOL="${PROJECT_ROOT}/tools/ktouch2typ.pl"

mkdir -p "${BUILD_DIR}"


for lesson in ${LESSONS}; do
    base_name=`basename ${lesson}`
    stp=$(( ${#base_name} - 11 ))
    lesson_name=${base_name:0:$stp}
    result_path="${BUILD_DIR}/${lesson_name}.typ"
    echo -n "Convert ${base_name} ..."
    cd "${PROJECT_ROOT}/tools"
    ./ktouch2typ.pl "${lesson}" > /dev/null
    cd "${PROJECT_ROOT}"
    mv -f "${PROJECT_ROOT}/${lesson_name}.ktouch.typ" "${result_path}"
    echo " OK"
done