rm /openssl/certs/*
echo "a!v€r1L0ng@nd[0mpl1c4t3dp4ssw0rd@#£" > /openssl/certs/password.txt
cat /openssl/certs/password.txt | openssl genrsa -passout stdin -des3 -out /openssl/certs/ca.key 4096
cat /openssl/certs/password.txt | openssl req -passin stdin -new -x509 -days 365 -key /openssl/certs/ca.key -out /openssl/certs/ca.crt \
  -subj "/C=IT/ST=Italy/L=Cosenza/O=No Organization/CN=justacertificateauthority.com/emailAddress=${EMAIL_ADDRESS}"
cat /openssl/certs/password.txt | openssl genrsa -passout stdin -des3 -out /openssl/certs/server.key 4096
cat /openssl/certs/password.txt | openssl req -passin stdin -new -key /openssl/certs/server.key -out /openssl/certs/server.csr \
  -subj "/C=IT/ST=Italy/L=Cosenza/O=No Organization/CN=${SERVER_COMMON_NAME}/emailAddress=${EMAIL_ADDRESS}"
cat /openssl/certs/password.txt | openssl x509 -passin stdin -req -days 365 -in /openssl/certs/server.csr -CA /openssl/certs/ca.crt -CAkey /openssl/certs/ca.key -set_serial 01 -out /openssl/certs/server.crt
cat /openssl/certs/password.txt | openssl genrsa -passout stdin -des3 -out /openssl/certs/client.key 4096
cat /openssl/certs/password.txt | openssl req -passin stdin -new -key /openssl/certs/client.key -out /openssl/certs/client.csr \
  -subj "/C=IT/ST=Italy/L=Cosenza/O=No Organization/CN=${CLIENT_COMMON_NAME}/emailAddress=${EMAIL_ADDRESS}"
cat /openssl/certs/password.txt | openssl x509 -passin stdin -req -days 365 -in /openssl/certs/client.csr -CA /openssl/certs/ca.crt -CAkey /openssl/certs/ca.key -set_serial 01 -out /openssl/certs/client.crt