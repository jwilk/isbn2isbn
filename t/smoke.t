#!/usr/bin/env bash

# Copyright © 2021-2024 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/isbn2isbn"
declare -i n
run()
{
    out=$("$prog" "$@")
}
expect()
{
    n+=1
    xout="$1"
    diff=$(diff -u <(cat <<< "$xout") <(cat <<< "$out")) || true
    if [ -z "$diff" ]
    then
        echo "ok $n"
    else
        sed -e 's/^/# /' <<< "$diff"
        echo 'not ok $n'
    fi
}
echo 1..2
run -n 13 8371520883
expect 9788371520884
run -n 10 9788371520884
expect 8371520883

# vim:ts=4 sts=4 sw=4 et ft=sh
