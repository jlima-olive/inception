FROM debian:oldstable

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -new -noenc -keyout /etc/nginx/ssl/inception.key \
	-subj /C=PT/L=LX/O=42/OU=42/CN=jlima-so.42.fr/UID=jlima-so \
	-days 365 -out /etc/nginx/ssl/inception.crt

#-subj = gives arguments for the creation of the certificate
#-new = output a new certificate request
#-x509 = output certificate instead of certificate request
#-noenc = if this creates a new key for the certificate do not encript it
#-days = if creating a certificate this tells for how many days the certificate is valid  

#-keyout filename = generates a new key and outputs it to filename
# why /etc/nginx/ssl/ 

#-out = certificate output
# why /etc/nginx/ssl/
 
COPY ./nginx.conf /etc/nginx/nginx.conf
# why /etc/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]