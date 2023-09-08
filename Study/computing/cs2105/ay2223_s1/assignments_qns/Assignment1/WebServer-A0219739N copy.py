import sys
from socket import * 

keyStore = {}
countStore = {}

def repKey(method, key, body):
    if method == "get":
        if key in keyStore.keys():
            repBody = keyStore[key]

            if key in countStore.keys():
                countStore[key] -= 1
                if countStore[key] == 0:
                    keyStore.pop(key)
                    countStore.pop(key)
            
            return b'200 OK Content-Length %d  %b' % (len(repBody), repBody)
        else:
            return b'404 NotFound  '
    elif method == "post":
        if key in countStore.keys():
            return b'405 MethodNotAllowed  '
        else:
            keyStore[key] = body
            return b'200 OK  '
    elif method == "delete":
        if key in countStore.keys():
            return b'405 MethodNotAllowed  '
        else:
            if key in keyStore.keys():
                repBody = keyStore.pop(key)
                return b'200 OK Content-Length %d  %b' % (len(repBody), repBody)
            else:
                return b'404 NotFound  '


def repCount(method, key, body):
    if method == "get":
        if key in keyStore.keys():
            repBody = str(countStore.get(key, 'Infinity')).encode()
            return b'200 OK Content-Length %d  %b' % (len(repBody), repBody)
        else:
            return b'404 NotFound  '
    elif method == "post":
        if key not in keyStore.keys():
            return b'405 MethodNotAllowed  '

        if key not in countStore.keys():
            countStore[key] = 0
        countStore[key] += int(body)
        return b'200 OK  '
    elif method == "delete":
        if key in countStore.keys():
            repBody = str(countStore.pop(key)).encode()
            return b'200 OK Content-Length %d  %b' % (len(repBody), repBody)
        else:
            return b'404 NotFound  '


def parseHeader(header, headerMap):
    header = header.decode()
    headerMap.clear()
    words = header.split(" ")
    headerMap["method"] = words[0].lower()
    headerMap["path"] = words[1]
    for i in range(2, len(words), 2):
        headerMap[words[i].lower()] = words[i+1]


def sendResponse(connectionSocket, clientAddress, headerMap, body):
    pathWords = headerMap["path"].split("/")
    method = headerMap["method"]
    store = pathWords[1]
    key = pathWords[2]

    if store == "key":
        rep = repKey(method, key, body)
    elif store == "counter":
        rep = repCount(method, key, body)

    # print('rep: ', rep)
    connectionSocket.send(rep)
    

serverPort = int(sys.argv[1])
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))


while True:
    serverSocket.listen()
    connectionSocket, clientAddress = serverSocket.accept()
    header = b''
    headerMap = {}
    body = b''
    bodyLeft = 0
    disconnect = False

    while True:
        try:
            message = connectionSocket.recv(4096)
        except:
            disconnect = True

        if disconnect or len(message) == 0:
            break 

        # print('message: ', message)
    
        messageNext = 0
        while messageNext != len(message):
            if not bodyLeft:
                headerEnd = message.find(b'  ', messageNext)
                if headerEnd == -1:
                    header += message[messageNext:]
                    messageNext = len(message)
                    headLeft = True
                else:
                    header += message[messageNext:headerEnd]
                    messageNext = headerEnd + 2
                    parseHeader(header, headerMap)
                    headLeft = False
                    bodyLeft = int(headerMap.get("content-length", 0))

            if bodyLeft:
                append = message[messageNext:messageNext + bodyLeft]
                body += append
                bodyLeft -= len(append)
                messageNext += len(append)

            if not bodyLeft and not headLeft:
                # print('header: ', headerMap)
                # print('body: ', body)
                sendResponse(connectionSocket, clientAddress, headerMap, body)
                body = b''
                header = b''

    connectionSocket.close()