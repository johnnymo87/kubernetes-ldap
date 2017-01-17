FROM golang:1.7-alpine

RUN apk add --update make && \
    apk add --update curl && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/kismatic/kubernetes-ldap
ADD . /go/src/github.com/kismatic/kubernetes-ldap

RUN make

CMD ./bin/kubernetes-ldap --ldap-host ldap_server \
    --ldap-base-dn "DC=example,DC=com" \
    --tls-cert-file ssl/ldap_server.cert.pem \
    --tls-private-key-file ssl/ldap_server.key.pem \
    --ldap-skip-tls-verification true \
    --ldap-user-attribute idkwhatthisis \
    --ldap-search-user-dn "jon" \
    --ldap-search-user-password secret
