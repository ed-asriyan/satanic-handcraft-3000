#!/usr/bin/env bash
/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/home/ubuntu/.ssh/haka.pem" $1 $2

