koji-add-user
=============
Simple init script for adding a new user to Koji and setting them up for builds.

Usage
-----
To use this, become root and do

    # koji-add-user <user>

This does several things:

- Adds them as a user in Koji and grants them admin access. This should be done
  by a user who has admin access in the first place - typically anyone.
- Generates certificates.
- Copies the certificates to the new user's home directory.

Walkthrough
-----------
When creating the certificate, you'll be asked to enter some information that
will become a part of the certificate. If the system is set up correctly, you'll
most of these will have the proper defaults already set up.

- Country Name: `US`
- State or Province Name: `New Jersey`
- Locality Name: `Piscataway`
- Organization Name: `Open System Solutions`
- Organizational Unit Name: Left blank
- Common Name: Your NetID
- Email Address: Your NBCS Email address
- Challenge Password: Left blank
- Optional Company Name: Left blank

When prompted, sign the certificate and commit it. This will append a new line
to the database, which is typically `/etc/pki/koji/index.txt/`.

Finally, this will copy the certificates to your home directory. Fedora
recommends that they are saved as

    ~/.fedora.cert
    ~/.fedora-upload-ca.cert
    ~/.fedora-server-ca.cert

To use them, you'll have to copy them to your home directory on each build
machine you use.
