#!/bin/bash
echo | openssl s_client -connect 172.16.50.8:443 -showcerts 2>&1 | sed  -n '/BEGIN CERTIFICATE/,/-END CERTIFICATE-/p'> ssl/apicgw.pem
