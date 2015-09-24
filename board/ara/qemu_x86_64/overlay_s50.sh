#!/bin/bash

sed -i "8s#^#GB=$BUILD_DIR/greybus-master#" $TARGET_DIR/etc/init.d/S50greybus

# This set password root to root
#sed -i 's%^root::%root:8kfIfYHmcyQEE:%' $TARGET_DIR/etc/shadow
