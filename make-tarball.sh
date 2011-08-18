#!/bin/bash

if [[ $# -ne 2 ]] ; then
	cat <<-EOF 1>&2
	Usage: $0 <module> <ver>
	EOF
	exit 1
fi

# be nice to tab completers
mod=${1##*/}
mod=${mod//eselect}
mod=${mod//[-.]}
ver=$2
dir="eselect-${mod}-${ver}"

comp_bin="xz"
comp_sfx="xz"
tar="${dir}.tar.${comp_sfx}"

set -e
rm -rf "${dir}"
mkdir "${dir}"
cp AUTHORS ChangeLog README "${dir}"
m="man/${mod}.eselect.5"
if [[ -e ${m} ]] ; then
	cp ${m} "${dir}"
fi
cp modules/${mod}.eselect "${dir}"

tar cf - "${dir}" | ${comp_bin} > ${tar}
rm -rf "${dir}"
du -b ${tar}
