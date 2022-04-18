#!/usr/bin/python

import socket
import socketserver
import http.server

def isOpen(ip,port):
  sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  try:
    sock.connect((ip, int(port)))
    sock.shutdown(socket.SHUT_RDWR)
    return True
  except:
    return False
  finally:
     sock.close()

Handler = http.server.SimpleHTTPRequestHandler
i=1

text_line = open("/root/info","r")
ips = text_line.readline().replace("\""," ").split(' ')
port = text_line.readline().split('"')
text_line.close()

while i < len(ips)-1:
  if isOpen(ips[i],port[1]):
    print('Port',port[1],'on the local server',ips[i],'is busy')
  else:
    print('Port',port[1],'on the local server',ips[i],'is not busy')
    print('Starting a simple http server on the port',port[1])
    with socketserver.TCPServer(("", int(port[1])), Handler) as httpd:
      print("serving at port", port[1])
      httpd.serve_forever() 
  i=i+1
