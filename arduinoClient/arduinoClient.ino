/*
  Baguette Client
  
 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13
 
 created 18 Dec 2009
 modified 9 Apr 2012
 by David A. Mellis
 modified 19 May 2013
 by Martin d'Allens and Maxime Morin
 
 */

#include <SPI.h>
#include <Ethernet.h>


#define SERVER       "dallens.fr"
#define PORT         1234
#define STATUS_PIN   13

#define DEBUG(str)   Serial.println(str);

// Newer Ethernet shields have a MAC address printed on a sticker on the shield
byte mac[] = { 0x90, 0xA2, 0xDA, 0x0D, 0xA0, 0x29 };

IPAddress dev(192,168,0,20); // Unused.
IPAddress fixed(192,168,0,199); // Unused.

EthernetClient client;

void setup() {
  pinMode(STATUS_PIN, OUTPUT);
  
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }
  
  DEBUG("REBOOT")
}


void loop()
{
   int i;
   
   delay(1000); // Limit the rate of connexions.
   DEBUG("LOOP")
   
   if (Ethernet.begin(mac) == 0) { // Connectivity or DHCP error.
      return;
   }
   DEBUG("DHCP_OK")
   
   if (!client.connect(dev, PORT)) {
      return; // Might be a firewall error.
   }
   DEBUG("CONNECT_OK")
   
   if (client.available()) {
      DEBUG("SERVER_FIRST")
      return; // The server shouldn't send anything first.
   }
  
   client.print("{\"identifier\": \"");
   for (i = 0; i < 6; i++) {
      client.print(mac[i], HEX);
   }
   client.print("\", \"key\": \"ABCDEF0123456789\"}\r\n");
   client.flush();
   
   DEBUG("ALL_OK")
   
   digitalWrite(STATUS_PIN, HIGH);
   while (client.connected()) {
      if (client.available()) {
         Serial.write(client.read());
      }
      if (Serial.available()) {
         client.write(Serial.read());
      }
   }
   digitalWrite(STATUS_PIN, LOW);
   
   DEBUG("DISCONNECT")
   
   client.stop();
}

