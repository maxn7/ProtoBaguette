#!/usr/bin/env python2
# django auth http://tornadogists.org/654157/

import base64
import ssl
import socket
import time
import tornado.ioloop
import tornado.web
import tornado.httpserver
import tornado.websocket


STATIC_PATH = "./static"
CERTFILE = "startssl2048.pem" # "autocert1024.pem"
HOST = "baguette.hexabread.com"
PORT = 443

PING_RESOLUTION = 5
PING_START = 30
PING_MAXIMUM = 60

channels = {}

def send_pings():
    for channel_id, channel in channels.items():
        for client in channel:
            elapsed = time.time() - client.last_seen
            if elapsed > PING_START and not client.ping_sent:
                client.ping_sent = True
                client.ping("")
            elif elapsed > PING_MAXIMUM:
                print("Ping timeout")
                client.close()
                client.on_close()

class BaguetteHandler(tornado.websocket.WebSocketHandler):
    def open(self, arg):
        self.channel_id = arg
        self.last_seen = time.time()
        self.ping_sent = False
        self.join_channel()

        auth = self.request.headers.get("Authorization")
        if auth and auth.startswith("Basic "):
            try:
                user, password = base64.decodestring(auth[6:]).split(':', 2)
                print("User '%s', password '%s'" % (user, password))
            except:
                print("Invalid authorization '%s'" % auth)

        #~ # 10 seconds keep alive
        #~ sock = self.request.connection.stream.socket
        #~ sock.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
        #~ sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPIDLE, 30)
        #~ sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPINTVL, 10)
        #~ sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 3)

    def on_message(self, message):
        self.last_seen = time.time()
        self.write_to_channel(message)

    def write_to_channel(self, message):
        for client in channels[self.channel_id]:
            if client != self:
                client.write_message(message)

    def on_close(self):
        self.quit_channel()

    def on_pong(self, data):
        self.ping_sent = False
        self.last_seen = time.time()

    def join_channel(self):
        if not self.channel_id in channels:
            channels[self.channel_id] = []
            print("Channel %s created" % self.channel_id)
        
        channels[self.channel_id].append(self)

    def quit_channel(self):
        channel = channels[self.channel_id]
        channel.remove(self)
        self.write_to_channel("Dude disconnected\r\n")
        
        if not channel:
            del channels[self.channel_id]
            print("Channel %s closed" % self.channel_id)


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("""<html>
<head>
<title>Tests ProtoBaguette</title>
</head>
<body>
<form onsubmit="conn(); return false">Channel : <input type="text" id="chan"> <input type="submit" value="Connect"></form>
<form onsubmit="send(); return false">Message : <input type="text" id="message" size="60"> <input type="submit" value="Send"></form>
<pre id="log"></pre>
<script>
var ws = false;
function conn() {
   if(ws)
      ws.close();
   ws = new WebSocket("%s://%s/channel/" + document.getElementById('chan').value);
   ws.onopen = function() {
      ws.send("Hello\\r\\n");
   };
   ws.onmessage = function (evt) {
      document.getElementById('log').innerText += evt.data;
   };
}
function send() {
   ws.send(document.getElementById("message").value + "\\r\\n");
}
</script>
</body>
</html>""" % (("wss" if PORT == 443 else "ws"), HOST))




if __name__ == "__main__":
    application = tornado.web.Application([
            (r"/channel/(.+)", BaguetteHandler),
            (r"/",             MainHandler),
        ],
        static_path=STATIC_PATH,
        debug=True,
        gzip=True)
    
    application.listen(PORT,
                       address=HOST,
                       ssl_options={"certfile": CERTFILE, "ssl_version": ssl.PROTOCOL_SSLv3})
    
    main_loop = tornado.ioloop.IOLoop.instance()
    scheduler = tornado.ioloop.PeriodicCallback(send_pings,
                                                PING_RESOLUTION * 1000,
                                                io_loop = main_loop)
    
    scheduler.start()
    main_loop.start()
