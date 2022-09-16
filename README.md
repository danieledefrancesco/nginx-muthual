# NGINX - Muthual

A sample project to help run a nginx backend to test muthual authentication

## Requirements
- Docker
- Docker compose

## Usage

### 1 - Create the certificates
The command to create the certificates is the following:

```
docker-compose up openssl
```
In order to change the common name to use for the client and/or the server change the variables in the `./openssl/.env`file before running the command

### 2 - Run nginx
To run nginx use the following:
```
docker-compose up -d nginx
```

### 3 - Test
To test that the server requires a client certificate run the following:
```
curl --cacert ./openssl/certs/ca.crt  https://localhost:8443
```
To test that the server responds when a client certificate is provided run the following:
```
password=$(cat ./openssl/certs/password.txt) curl --cacert ./openssl/certs/ca.crt  -v -s -k --key ./openssl/certs/client.key --cert ./openssl/certs/client.crt:${password} "https://127.0.0.1:8443"
```