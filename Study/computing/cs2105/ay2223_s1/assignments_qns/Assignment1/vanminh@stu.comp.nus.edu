import sys
from socket import * 

keyStore = {}
countStore = {}

# handle key-value store
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

# handle count store
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

# map header string to header dictionary
"""
{
    "method": "post",
    "path": "/key/cs2105",
    "content-length": 27
} 
"""
def parseHeader(header, headerMap):
    header = header.decode()
    headerMap.clear()
    words = header.split(" ")
    headerMap["method"] = words[0].lower()
    headerMap["path"] = words[1]
    for i in range(2, len(words), 2):
        headerMap[words[i].lower()] = words[i+1]

# handle request and send back
def sendResponse(connectionSocket, headerMap, body):
    pathWords = headerMap["path"].split("/")
    method = headerMap["method"]
    store = pathWords[1]
    key = pathWords[2]

    if store == "key":
        rep = repKey(method, key, body)
    elif store == "counter":
        rep = repCount(method, key, body)

    connectionSocket.send(rep)
    

serverPort = int(sys.argv[1])
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))


while True:
    # each loop for one client
    serverSocket.listen()
    connectionSocket, clientAddress = serverSocket.accept()
    # current request info
    header = b'' # header string
    headerMap = {} # mapped headers
    body = b''
    bodyLeft = 0 # length of the body not received
    disconnect = False # recv() raised an exception and connection socket is useless 

    while True:
        try:
            message = connectionSocket.recv(4096)
        except:
            disconnect = True

        if disconnect or len(message) == 0:
            break 
    
        # reading index of the msg
        messageNext = 0
        # read 'til end of msg
        while messageNext != len(message):
            # not expecting a body part (of prev segment)
            # => read as part of header
            if not bodyLeft:
                # find the end of the header
                headerEnd = message.find(b'  ', messageNext)
                # not found => partial header
                # => add to header string
                if headerEnd == -1:
                    header += message[messageNext:]
                    messageNext = len(message)
                    # = header not complete
                    headLeft = True
                # found => can complete a header
                # => map to a dictionary and get the length of body to `bodyLeft`
                else:
                    header += message[messageNext:headerEnd]
                    messageNext = headerEnd + 2
                    parseHeader(header, headerMap)
                    # = header completed 
                    headLeft = False
                    bodyLeft = int(headerMap.get("content-length", 0))
            # expecting part of req body
            if bodyLeft:
                append = message[messageNext:messageNext + bodyLeft]
                body += append
                bodyLeft -= len(append)
                messageNext += len(append)
            # = body complete and header complete
            if not bodyLeft and not headLeft:
                sendResponse(connectionSocket, headerMap, body)
                body = b''
                header = b''

    connectionSocket.close()