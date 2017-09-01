# Configure TLS end to end between Bluemix app and back end service


The connection between bluemix app to back end data access service needs to be over HTTPS, HTTP over SSL. To make SSL working end to end we need to do certificate management, configure trust stores, understand handshaking, and other details that must be perfectly aligned to make the secure communication work.

## Quick TLS summary

TLS and SSL uses public key/private key cryptography to encrypt data communication between the server and client, to allow the server to prove its identity to the client, and the client to prove its identity to the server.

Three fundamental components are involved in setting up an SSL connection between a server and client:
* a certificate,
* a public key,
* a private key.   
Certificates are used to identify an identity: (CN, owner, location, state,... using the X509 distinguished name).

Entity can be a person or a computer. As part of the identity, the CN or Common Name attribute is the name used to identify the domain name of the server host.

To establish a secure connection to API Connect server, a client first resolves the domain name as specified in CN. After the SSL connection has been initiated, one of the first things the server will do is send its digital certificate. The client will perform a number of validation steps before determining if it will continue with the connection. Most importantly, the client will compare the domain name of the server it intended to connect to (in this case, 172.16.50.8) with the common name (the “CN” field) found in the subject’s identity on the certificate. If these names do not match, it means the client does not trust the identity of the server. This is the hand shake step.

Public keys and private keys are number pairs with a special relationship. Any data encrypted with one key can be decrypted with the other. This is known as asymmetric encryption. The server’s public key is embedded within its certificate. The public key is freely distributed so anyone wishing to establish an encrypted channel with the server may encrypt their data using the server’s public key. Data encrypted with a private key may be decrypted with the corresponding public key. This property of keys is used to ensure the integrity of a digital certificate in a process called digital signing.

In term of server / certificate we need to prepare the following schema may help to understand the dependencies:
![](./ssl-cert-e2e.png)
API Gateway has its own public certificate, and the Secure Gateway has also one.

We need to do multiple things to get the connection end to end to be over TLS socket:
* Get SSL Certificate for the API Connect Gateway end point from a Certificate Agency given domain name, with assured identity. The IBM self certified certificate should not work when the client will do a hostname validation. For *Brown Compute* we are still using the self certified certificate and we will highlight the impact on the client code.
* Define TLS profile configuration for API Connect using the Cloud Management console
* Get certificate for each of the components in the path

Let go over those steps in details:

## pre-requisites
You need to have [openssl](https://www.openssl.org/) installed on your computer. For MAC users it is already installed. If you need to install see instruction [here](https://www.openssl.org/source/)

## 1. Get Secure Gateway certificate

The following command returns a lot of helpful information from a server like the IBM Secure Gateway we [configured](https://github.com/ibm-cloud-architecture/refarch-integration-utilities/blob/master/docs/ConfigureSecureGateway.md) on Bluemix.
`openssl s_client -connect cap-sg-prd-5.integration.ibmcloud.com:16582`

In the returned output, we can see the certificate chain presented by the server with the subject and issuer information:
```
Certificate chain
 0 s:/C=US/ST=NC/L=Durham/O=IBM Corporation/OU=SWG/CN=*.integration.ibmcloud.com
   i:/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
 1 s:/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
   i:/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert Global Root CA
```
one important output is the protocol and cipher suite used:
```
SSL-Session:
    Protocol  : TLSv1
    Cipher    : AES256-SHA
```
If we need to keep the server's PEM-encoded certificate save the ---BEGIN CERTIFICATE  to END CERTIFICATE to a file: sg.pem for this example. The following command will do it for you:
`echo | openssl s_client -connect cap-sg-prd-5.integration.ibmcloud.com:16582 -showcerts 2>&1 | sed  -n '/BEGIN CERTIFICATE/,/-END CERTIFICATE-/p'> sg.pem `

By default, s_client will print only the leaf certificate; as we want to print the entire chain, we use -showcerts switch.

Use this certificate for the client code in Bluemix.

As an alternate we can download the authentication files from the Secure Gateway destination:  
![](sg-dest-detail.png)  
as explained in [this article](https://github.com/ibm-cloud-architecture/refarch-integration-utilities/blob/master/docs/ConfigureSecureGateway.md#step-3--define-destination-for-secure-gateway-service) and use all those certificates files to define the connection.

## 2. Get the APIC server certificate
When connected via VPN to your on-premise environment, you can get the TLS certificate for the API Connect Gateway server via the command:
`echo | openssl s_client -connect 172.16.50.8:443 -showcerts 2>&1 | sed  -n '/BEGIN CERTIFICATE/,/-END CERTIFICATE-/p'> apicgw.pem `

## 3. Using Self certified TSL certificates in a client app
To make TSL working end to end we need to do certificate management, configure trust stores, understand handshaking, and other details that must be perfectly aligned to make the secure communication work.

We assume we downloaded the different certificates from secure gateway, the connection between the client app and the secure gateway is via TLS mutual auth.

### Nodejs app
Using the `request` module we can use the different certificates as settings to the `options` argument of the connection. Here is an example of a HTTP GET over TLS:

```javascript
request.get(
    {url:'https://cap-sg-prd-5.integration.ibmcloud.com:16582/csplab/sb/sample-inventory-api/items',
    timeout: 10000,
    headers: {
      'x-ibm-client-id': '1dc939dd-xxxx',
      'accept': 'application/json',
      'content-type': 'application/json'
      }
    });
```
So we need to prepare those input files on the client side (in the Case inc portal code source for example):
* Create a key store with the openssl tool.
`openssl pkcs12 -export -in "./ssl/qsn47KM8iTa_O495D_destCert.pem" -inkey "./ssl/qsn47KM8iTa_O495D_destKey.pem" -out "ssl/sg_key.p12" -name "CaseIncCliCert" -noiter -password pass:"asuperpwd"`
 The file is sg_key.p12
* Create a trust store from the DigiCertCA2.pem file
`keytool -import -alias PrimaryCA -file /ssl/DigiCertCA2.pem -storepass password -keystore /ssl/sg_trust.jks`
* Then for the secondary CA
`keytool -import -alias SecondaryCA -file /ssl/DigiCertTrustedRoot.pem -storepass password -keystore /ssl/sg_trust.jks`
* finally the certificate for the secure gateway
`keytool -import -alias BmxGtwServ -file /ssl/secureGatewayCert.pem -storepass password -keystore /ssl/sg_trust.jks`


### Step 5- Download the API Connect certificate  



To access the certificate use a Web browser, like Firefox, to the target URL using HTTPS. Access the Security > Certificate from the locker icon on left side of the URL field. (Each web browser has their own way to access to the self certified certificates)

![Certificate](APIC-cert.png)

Use the export button to create a new local file with suffix .crt. From there you need to persist the file on the operating system trust store.

 ```
# get certificate in the form of a .crt file, then mv it to ca-certificate
$ sudo mv APIConnect.crt /usr/local/share/ca-certificate
# To add en try to the certificates use the command
$ sudo update-ca-certificates
# verify with
$ ls -al /etc/ssl/certs | grep APIConnect
$ openssl s_client -showcerts -connect 172.16.50.8:443
```

## Specific to Java Trust store
Java Runtime Environment comes with a pre-configure set of trusted certificate authorities. The collection of trusted certificates can be found at $JAVA_HOME/jre/lib/security/cacerts The tests are run on the utility server, so the API Connect server CA certificate needs to be in place. To do so the following needs to be done:

Remote connect to the API Connect Gateway Server with a Web Browser and download the certificate as .crt file
```
$ sudo keytool -import -trustcacerts -alias brownapic -file APIConnect.crt -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit
$ keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts
```

Attention these steps will make the Java program using HTTP client working only if the certificate is defined by a certified agency. The self generated certificate has a CN attribute sets to a non-hostname, and HTTP client in Java when doing SSL connection are doing a hostname verification. See the test project for the detail on how it was bypassed, in Brown compute.

# References
* Open SSL [web site](http://www.openssl.org)
* [SSL Cookbook](https://www.feistyduck.com/library/openssl-cookbook/online/ch-testing-with-openssl.html)
