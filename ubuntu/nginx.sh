#! /bin/bash

apt-get update
apt-get install -y nginx
apt-get install -y stress
cd /var/www/html
rm index.html -f

META_HOSTNAME=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/hostname" -H "Metadata-Flavor: Google")
HOSTNAME=`echo $META_HOSTNAME | awk -F. '{print $1}'`

cat <<EOF > index.html
<h1>
HOSTNAME: change_name
</h1>
EOF

sed -i "s/change_name/$HOSTNAME/g" index.html

systemctl enable nginx