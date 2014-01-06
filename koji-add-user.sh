#!/bin/bash
# koji-add-user: Add a new user to Koji

show_usage() {
    echo "Usage: koji-add-user <user>"
    echo "This should be run as someone with Koji admin access."
}

if [ $# -ne 1 ]; then
    echo "koji-add-user: Error: Only one argument expected."
    exit 1
elif [ $HOSTNAME != "omachi.rutgers.edu" ]; then
    echo "koji-add-user: This script should only be done on omachi."
    exit 1
fi

case $1 in
    --help|-h|help)
        show_usage
        exit 0
        ;;
    *)
        if $(id $1) ; then
            echo "koji-add-user: Error: User $1 does not exist."
            exit 1
        fi
        ;;
esac

user=$1

echo "BREAK 1"

echo "Becoming root..."
certdir=~/koji
cd $certdir

echo "BREAK 2"

echo "Current user $(whoami)"

echo "Generating a new key..."
# error here
openssl genrsa -out certs/${user}.key 2048

echo "BREAK 3"

echo "Creating certificate..."
openssl req -config ssl.cnf -new -nodes -out certs/${user}.csr -key certs/${user}.key

echo "BREAK 4"

echo $certdir

echo "Copying certificates..."
openssl ca -config ssl.cnf -keyfile private/koji_ca_cert.key -cert koji_ca_cert.crt -out certs/${user}.crt -outdir certs -infiles certs/${user}.csr
cat certs/${user}.crt certs/${user}.key > ${user}.pem
cp ${user}.pem /heroes/u1/$1/.fedora.cert
cp $certdir/koji_ca_cert /heroes/u1/$1/.fedora-upload-ca.cert
cp $certdir/koji_ca_cert /heroes/u1/$1/.fedora-server-ca.cert

echo "Complete. You now have three certificates in your home directory:"
echo -e "\t/heroes/u1/$1/.fedora.cert"
echo -e "\t/heroes/u1/$1/.fedora-upload-ca.cert"
echo -e "\t/heroes/u1/$1/.fedora-server-ca.cert"
echo "To use Koji on a build machine, copy these certificates there via scp."
