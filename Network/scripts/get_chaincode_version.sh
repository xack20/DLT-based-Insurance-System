#!/bin/bash
# @Author: Md. Minhazul Haque Fahim
# @Date:   2024-01-19 20:15:11
# @Last Modified by:   Zakaria Hossain Foysal
# @Last Modified time: 2024-07-03 23:46:24
# cmd1=$1

ccn=$(docker ps --filter "name=$1" --format '{{.Names}}')
# echo $ccn

readarray -d _ -t strarr <<<"$ccn"

cns=${strarr[1]}
# echo $cns
readarray -d . -t strarr <<<"$cns"

CCV=${strarr[0]}
# echo $CCV


echo "CCV=`expr $CCV`"