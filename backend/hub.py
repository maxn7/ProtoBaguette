#!/usr/bin/env python

# TODO case insensitive
# TODO different identifiers for baguettes
# TODO default channel
# TODO show history
# TODO send \r\n but accept \n in reception

# TODO aggregate messages with a 1 second buffer
# todo rename "part"

import re
import socket
import time
import uuid
import json
from twisted.protocols.basic import LineReceiver
from twisted.internet.protocol import Factory
from twisted.internet import reactor

LOG_FOLDER = "./logs/" # TODO absolute
CLIENT_ID_LENGTH = 8 # 4 bytes in binary
CHANNEL_ID_LENGTH = 8
KEY_LENGTH = 32


def decrypt_buffer(received_buffer, key):
    return received_buffer # TODO use AES


def generate_key(client_id):
    return "0000000000000000" # TODO compute key


def generate_identifier(length):
    return uuid.uuid4().hex[0:length]


def is_valid_identifier(identifier):
    if re.match("[^0-9A-F]", identifier): # TODO better alphabet
        return False
    if len(identifier) > 16: # TODO better len
        return False
    return True


class Channel(object):
    def __init__(self, identifier, server):
        self.identifier = identifier
        self.server = server
        self.clients = []
        self.log_file = open(LOG_FOLDER + identifier, 'ab')
        
        print('Init channel "%s"' % identifier)
    
    def broadcast_event(self, event):
        event_text = json.dumps(event)
        self.log_file.write(event_text + "\r\n")
        for client in self.clients:
            if client.identifier != event["source"]:
                client.send_event(event, event_text)
    
    def join(self, client):
        event = {"event": "join", "source": client.identifier, "timestamp": time.time()}
        if client.name != None:
            event["sourceName"] = client.name
        self.broadcast_event(event)
        self.clients.append(client)
    
    def part(self, client):
        event = {"event": "part", "source": client.identifier, "timestamp": time.time()}
        if client.name != None:
            event["sourceName"] = client.name
        
        self.clients.remove(client)
        self.broadcast_event(event)
        
        if not self.clients: # Remove the channel if empty.
            del self.server.channels[self.identifier]
    
    def __del__(self):
        print('Delete channel "%s"' % self.identifier)
        self.log_file.close()


class Client(LineReceiver):
    delimiter = "\n"
    
    def __init__(self, server):
        self.channel       = None
        self.identifier    = None
        self.name          = None
        self.stream_format = None
        self.server        = server
        self.state         = "PREAMBLE"

    def send_event(self, event, event_text):
        if self.stream_format == "json":
            self.sendLine(event_text)
        else: # "raw" or None
            if event["event"] == "message":
                self.transport.write(event["message"])
            else:
                pass

    def connectionMade(self):
        self.transport.setTcpKeepAlive(1) # Enable keep-alive.
        self.transport.getHandle().setsockopt(socket.SOL_TCP, socket.TCP_KEEPIDLE, 30) # Linux specific.
    
    def connectionLost(self, reason):
        if self.channel != None:
            if self.state == "PREAMBLE":
                print("Client disconnected before preamble")
            else:
                self.channel.part(self)

    def lineReceived(self, line):
        if self.state == "PREAMBLE":
            preamble = json.loads(line)
            
            if preamble.has_key("identifier"):
                self.identifier = preamble["identifier"]
                if not is_valid_identifier(self.identifier):
                    raise Exception("Invalid identifier")
            else:
                self.identifier = generate_identifier(CLIENT_ID_LENGTH) # TODO make sure it's skipped only for baguettes
            
            if preamble.has_key("name"):
                self.name = preamble["name"]
            
            if preamble.has_key("key"): # TODO check key
                self.key = preamble["key"]
            else:
                raise Exception("Invalid key")
            
            if preamble.has_key("format"):
                self.key = preamble["format"]
            
            if preamble.has_key("channel"):
                channel_identifier = preamble["channel"]
            else:
                channel_identifier = self.identifier # TODO not for users
            
            self.channel = self.server.get_channel(channel_identifier)
            self.channel.join(self)
            self.setRawMode()
            self.state = "BODY"
        else:
            raise Exception("Line received in raw mode after preamble.")
    
    def rawDataReceived(self, data):
        if self.state != "BODY":
            raise Exception("Data received instead of preamble.")
        
        event = {"event": "message", "message": data, "source": self.identifier, "timestamp": time.time()} # TODO data to base64 ?
        if self.name != None:
            event["sourceName"] = self.name
        self.channel.broadcast_event(event)



class Server(Factory):
    def startFactory(self):
        self.channels = {}
    
    def buildProtocol(self, addr):
        return Client(self)

    #def stopFactory(self):
    # Actually all connexions are closed so there is no point in this.
        
        #for channel_id, channel in self.channels.iteritems():
        #    channel.broadcast_event({"event": "error", "error": "Server shutdown", "source": "server", "timestamp": time.time()})
        #    
        #self.channels = None # Closes all channels.
    
    def get_channel(self, channel_identifier):
        if not self.channels.has_key(channel_identifier):
            self.channels[channel_identifier] = Channel(channel_identifier, self)
        return self.channels[channel_identifier]


def main():
    server = Server()
    reactor.listenTCP(1234, server)
    print("Server started")
    reactor.run()
    print("Server stopped")


if __name__ == "__main__":
    main()
