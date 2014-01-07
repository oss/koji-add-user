koji-add-user
=============
Simple init script for adding a new user to Koji and setting them up for builds.

Usage
-----
To use this, become root and do

    # koji-add-user <user>

This does several things:
1. Adds them as a user in Koji and grants them admin access. This should be done
   by a user who has admin access in the first place - typically anyone.
2. Generates certificates. When prompted for your "common name", enter your
   username.
3. Copies the certificates to the new user's home directory.
