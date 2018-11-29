docker run --name test -h test -v $(pwd)/PASSWORD:/tmp/PASSWORD -p 9043:9043 -p 9444:9443 -d ibmcom/websphere-traditional:8.5.5.14-profile
