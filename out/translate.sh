#!/bin/sh

for f in `ls *.hydla.txt`; do
  grep -A 9 -e "checkConsistencyPoint\[" -e "checkConsistencyInterval\[" -e "minimizeTime\[" -e "compareMinTime" $f \
  | sed -E "/^@/d" \
  | sed -E "/^timer/d" \
  | sed -E "s/prev\[([[:alnum:]]*),[[:blank:]]([[:digit:]]*)\]/prev_\1_\2/g" \
  | sed -E "s/p\[([[:alnum:]]*),[[:blank:]]([[:digit:]]*),[[:blank:]]([[:digit:]]*)\]/p_\1_\2_\3/g" \
  | sed -E "s/\[/\(/g" \
  | sed -E "s/\]/\)/g" \
    > ${f%%.*}.txt
done
