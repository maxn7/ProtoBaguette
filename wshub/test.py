#!/usr/bin/env python2

import socket
import ssl

bindsocket = socket.socket()
bindsocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
bindsocket.bind(('baguette.dallens.fr', 443))
bindsocket.listen(5)
newsocket, fromaddr = bindsocket.accept()
conn = ssl.wrap_socket(newsocket,
                       server_side=True,
                       certfile="cert.pem",
                       keyfile="cert.pem",
                       ssl_version=ssl.PROTOCOL_SSLv3)
print "read"
print conn.read()
print "done"
conn.write('200 OK\r\n\r\n')
conn.close()
bindsocket.close()

