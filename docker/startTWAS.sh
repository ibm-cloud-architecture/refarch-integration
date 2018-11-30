docker run --name WAS855FP14 -h was855 -v $(pwd)/PASSWORD:/tmp/PASSWORD -p 9044:9043 -p 9444:9443 -d ibmcase/twas
