import sys
from socket import *
from zlib import crc32
from time import monotonic

start = monotonic()

inputStr = sys.stdin.buffer
outputStr = sys.stdout.buffer

serverAdress = ('localhost', int(sys.argv[1]))
aliceSocket = socket(AF_INET, SOCK_DGRAM)

seq = 0

while len(inputStr.peek(1)) > 0:
    payload = seq.to_bytes(1, 'big') + inputStr.read1(59)
    payload = crc32(payload).to_bytes(4, 'big') + payload
    while True:
        aliceSocket.sendto(payload, serverAdress)
        aliceSocket.settimeout(0.05)
        try:
            recvMsg, bAdd = aliceSocket.recvfrom(5)
            checksum = int.from_bytes(recvMsg[:4], 'big')
            rcvseq = recvMsg[4]
            if crc32(recvMsg[4:]) == checksum:
                if rcvseq == seq:
                    seq = not seq
                    break
                else:
                    continue
        except:
            continue


end = monotonic()

print(f'time elapse: {end - start}')