from socket import *

serverName = 'localhost'
serverPort = int(input('Server port: '))

clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))

reqs = [
    'GET /key/CS2105  ',
    'POST /key/CS2105 Content-Length 27  Intro To Computer Networks!',
    'POST /counter/CS2105 Content-Length 1  3',
    'GET /key/CS2105  ',
    'GET /counter/CS2105  ',
    'POST /counter/CS2105 Content-Length 1  2',
    'DELETE /key/CS2105  ',
    'DELETE /counter/CS2105  ',
    'GET /counter/CS2105  ',
    'DELETE /key/CS2105  '
]

for req in reqs:
    # print('req: ', req)
    clientSocket.send(req.encode())
    rMsg = clientSocket.recv(4096).decode()
    print('response: ', rMsg)