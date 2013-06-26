#!/usr/bin/env python2
# django auth http://tornadogists.org/654157/

import base64
import django.core.handlers.wsgi
import ssl
import socket
import time
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.websocket
import tornado.wsgi


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

    def on_message(self, message):
        self.last_seen = time.time()
        self.write_to_channel(message)
        print("Received " + ':'.join(x.encode('hex') for x in message))

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
<a href="/static/index.htm">Poupoupidou</a>
</body>
</html>""")


def main():
    django_wsgi = tornado.wsgi.WSGIContainer(django.core.handlers.wsgi.WSGIHandler())
    
    application = tornado.web.Application([
            (r"/channel/(.+)", BaguetteHandler),
            (r"/",             MainHandler),
            #(r".*", tornado.web.FallbackHandler, dict(fallback=django_wsgi)),
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


if __name__ == "__main__":
    main()
