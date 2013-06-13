#!/usr/bin/env python2

import ssl
import tornado.ioloop
import tornado.web
import tornado.httpserver
import tornado.websocket

# http://tornadogists.org/654157/
# http://stackoverflow.com/questions/11695375/tornado-identify-track-connections-of-websockets

host = "baguette.hexabread.com"
port = 443
channels = {}

class WSHandler(tornado.websocket.WebSocketHandler):
    def open(self, arg):
        self.channel_id = arg
        self.join_channel()

    def on_message(self, message):
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
        
        if not channel:
            del channels[self.channel_id]
            print("Channel %s closed" % self.channel_id)


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("""<html><head></head><body>
<pre id="log"></pre>
<script>
var ws = new WebSocket("%s://%s/channel/abc");
ws.onopen = function() {
   ws.send("Hello\\n");
};
ws.onmessage = function (evt) {
   document.getElementById('log').innerText += evt.data;
};
</script>
</body></html>""" % (("wss" if port == 443 else "ws"), host))


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
