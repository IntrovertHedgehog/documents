from ast import Num
from operator import concat
import sys
from datetime import datetime
from xmlrpc.client import DateTime

inputStream = sys.stdin.buffer
outputStream = sys.stdout.buffer

def printSize(payloadSize):
    while(len(inputStream.peek(1)) > 0):
        input = inputStream.read1(payloadSize)
        outputStream.write(input)
        outputStream.flush()
        payloadSize -= len(input)
        if (payloadSize == 0):
            break


header = ''
while (len(inputStream.peek(1)) > 0):
    next = inputStream.read(1).decode()
    header += next
    if (next == 'B'):
        pos = len(header) - 1
        payloadSize = int(header[6:pos])
        printSize(payloadSize)
        header = ''