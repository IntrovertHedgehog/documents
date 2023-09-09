# !/usr/bin/env python3
import os
import sys
from Cryptodome.Hash import SHA256

if len(sys.argv) < 3:
    print("Usage: python3 ", os.path.basename(__file__), "key_file_name document_file_name")
    sys.exit()

key_file_name   = sys.argv[1]
file_name       = sys.argv[2]

# get the authentication key from the file
with open(key_file_name, 'rb') as f:
    key = f.read()

# read the input file

# First 32 bytes is the message authentication code
# TODO
with open(file_name, 'rb') as f:
    mac_from_file = f.read(32)
    content_from_file = f.read()

mac_generated = SHA256.new(content_from_file + key).digest()

if mac_from_file == mac_generated:
    print ('yes')
else:
    print ('no')
