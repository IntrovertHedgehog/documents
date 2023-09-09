from socket import *
from zlib import crc32
from sys import argv, stdout

outputStream = stdout.buffer

buffer = []
bufferSize = 1 << 8

serverPort = int(argv[1])
serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind(('', serverPort))

lastAcked = 1
while True:
    message, clientAddress = serverSocket.recvfrom(64)
    checksum = int.from_bytes(message[:4], 'big')
    seq = message[4]
    if crc32(message[4:]) != checksum:
        ackMessage = lastAcked.to_bytes(1, 'big')
        ackMessage = crc32(ackMessage).to_bytes(4, 'big') + ackMessage
        serverSocket.sendto(ackMessage, clientAddress)
    elif lastAcked != seq:
        outputStream.write(message[5:])
        outputStream.flush()

        lastAcked = seq
    
    ackMessage = lastAcked.to_bytes(1, 'big')
    ackMessage = crc32(ackMessage).to_bytes(4, 'big') + ackMessage
    serverSocket.sendto(ackMessage, clientAddress)

