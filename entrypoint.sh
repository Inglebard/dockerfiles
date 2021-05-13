#!/bin/sh


cp /etc/hosts ~/hosts.new
sed "/$(hostname -i)/d" -i ~/hosts.new

final_mail_domain="$(hostname).localhost"
if [ ! -z "$MAIL_DOMAIN" ]
then
      final_mail_domain=$MAIL_DOMAIN
fi

echo "$(hostname -i)\t $final_mail_domain $(hostname)" >> ~/hosts.new

cp -f ~/hosts.new /etc/hosts
rm -f ~/hosts.new

makemap hash /etc/mail/access.db < /etc/mail/access
export DEBIAN_FRONTEND=noninteractive | /usr/sbin/sendmailconfig --no-reload

# run in foreground
sendmail -bD
