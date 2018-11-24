#!/bin/bash
echo "Install Dependencies"
sudo yum install compat-libstdc++-
echo "Install DB2 Express"
wget -c https://iwm.dhe.ibm.com/sdfdl/v2/regs2/db2pmopn/Express-C/DB2ExpressC11/Xa.2/Xb.aA_60_-i7xG4SSz7sABMK8uCtkhButYDKScfUpGoQDI/Xc.Express-C/DB2ExpressC11/v11.1_linuxx64_expc.tar.gz/Xd./Xf.LPr.D1vk/Xg.9936903/Xi.swg-db2expressc/XY.regsrvs/XZ.1UYI82ZNdczj3moAMeWjD3l0Zgo/v11.1_linuxx64_expc.tar.gz
tar -xvf v11.1_linuxx64_expc.tar.gzls
