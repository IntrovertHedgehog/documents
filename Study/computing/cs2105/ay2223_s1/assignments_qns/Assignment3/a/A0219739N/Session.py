import os.path
import sys
from Cryptodome.PublicKey import RSA
from Cryptodome.Cipher import PKCS1_v1_5, AES
from socket import *
from Cryptodome.Random import get_random_bytes

rsa_key_len = int(2048/8)


def load_rsa_key(f_name_key="test/rsa_key.bin"):
    """
    load the public RSA key
    :return: RSA key
    """
    with open(f_name_key, 'rb') as f:
        key = f.read()
    
    key = RSA.importKey(key)
    return key


# connect to the server
if len(sys.argv) < 5:
    print ("Usage: python3 ", os.path.basename(__file__), "key_file_name data_file_name hostname/IP port")
else:
    key_file_name   = sys.argv[1]
    data_file_name  = sys.argv[2]
    serverName      = sys.argv[3]
    serverPort      = int(sys.argv[4])
    print (serverName, serverPort)

    rsa_key         = load_rsa_key()

    # connect to the server
    clientSocket = socket(AF_INET, SOCK_STREAM)
    clientSocket.connect((serverName, serverPort))

    # get the session key
    # first 256 bytes sent by the server is the RSA encrypted session key
    cipher_rsa = PKCS1_v1_5.new(rsa_key)
    ciphertext = clientSocket.recv(256)
    sentinel = get_random_bytes(16)
    session_key = cipher_rsa.decrypt(ciphertext, sentinel)
    
    # write the session key to the file "key_file_name"
    with open(key_file_name, 'wb') as f:
        f.write(session_key)
        f.close()
    
    # get the data and write to file "data_file_name"
    cipher_aes = AES.new(session_key, AES.MODE_ECB)

    ciphertext = b''
    # get the data from server
    while True:
        new = clientSocket.recv(16)
        if len(new) == 0:
            break
        ciphertext = ciphertext + new
    # decrypt the data in blocks of size 16B
    # size of data from the server is guaranteed to be a multiple of 16B
    plaintext = cipher_aes.decrypt(ciphertext)
    
    with open(data_file_name, 'w') as f:
        f.write(plaintext.decode())
        f.close()

