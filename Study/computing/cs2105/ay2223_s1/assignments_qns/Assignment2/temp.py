from socket import *
import time

serverPort = 9000
serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind(('', serverPort))
print("The server is ready to receive")
while True:
    message, clientAddress = serverSocket.recvfrom(2048)
    time.sleep(3.1)
    modifiedMessage = message.decode().upper()
    serverSocket.sendto(modifiedMessage.encode(), clientAddress)
    print(clientAddress)

# serverName = 'localhost'
# serverPort = 12000

# clientSocket = socket(AF_INET, SOCK_DGRAM)
# message = input('Input lowercase sentence:')
# clientSocket.sendto(message.encode(),(serverName, serverPort))
# modifiedMessage, serverAddress = clientSocket.recvfrom(2048)
# #print(serverAddress)
# print(modifiedMessage.decode())
# clientSocket.close()