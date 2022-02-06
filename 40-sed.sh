#!/bin/sh
for k in $(env | grep ^VUE_APP | awk -F'=' '{print $1}')
do
  eval v=\$$k
  echo "Looking for ${k}=${v}";
  find /usr/share/nginx/html -type f -exec sed -i "s#SED_${k}#${v}#g" {} +
done

exit 0