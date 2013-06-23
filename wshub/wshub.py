#!/usr/bin/env python2

import ssl
import tornado.ioloop
import tornado.web
import tornado.httpserver
import tornado.websocket
import base64
import socket

# http://tornadogists.org/654157/
# http://stackoverflow.com/questions/11695375/tornado-identify-track-connections-of-websockets

host = "baguette.hexabread.com"
port = 443
channels = {}

class WSHandler(tornado.websocket.WebSocketHandler):
    def open(self, arg):
        self.channel_id = arg
        self.join_channel()

        auth = self.request.headers.get("Authorization")
        if auth and auth.startswith("Basic "):
            try:
                user, password = base64.decodestring(auth[6:]).split(':', 2)
                print("User '%s', password '%s'" % (user, password))
            except:
                print("Invalid authorization '%s'" % auth)

        # 10 seconds keep alive
        sock = self.request.connection.stream.socket
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
        sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPIDLE, 30)
        sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPINTVL, 10)
        sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 3)

    def on_message(self, message):
        self.write_to_channel(message)

    def write_to_channel(self, message):
        for client in channels[self.channel_id]:
            if client != self:
                client.write_message(message)

    def on_close(self):
        self.quit_channel()

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
</html>""" % (("wss" if port == 443 else "ws"), host))


application = tornado.web.Application([
        (r"/channel/(.+)", WSHandler),
        (r"/",             MainHandler),
    ],
    **{"debug": "True"})

if __name__ == "__main__":
    if port == 443:
        ssl = {"certfile": "startssl2048.pem", "ssl_version": ssl.PROTOCOL_SSLv3}
#        ssl = {"certfile": "autocert1024.pem", "ssl_version": ssl.PROTOCOL_SSLv3}
    else:
        ssl = None
    application.listen(port, address=host, ssl_options=ssl)
    tornado.ioloop.IOLoop.instance().start()
