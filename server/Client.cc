#include <cstdlib>
#include <cstring>	// strlen
#include <cstdio>
#include <iostream>
#include <string>
#include <regex>
#include "Socket.h"
#define PORT_INTER 4100

std::string parserResponse(char* serverResponseHTML) {
    std::string serverResponseHTMLS(serverResponseHTML);
    std::regex pattern("<TD ALIGN=center>([^<]+)</TD>");
    std::smatch matches;
    auto inicio = std::sregex_iterator(serverResponseHTMLS.begin(), serverResponseHTMLS.end(), pattern);
    auto fin = std::sregex_iterator();
    std::string serverResponsePlainText = "";
    for (std::sregex_iterator i = inicio; i != fin; ++i) {
        std::smatch match = *i;
        std::string matchString = match.str(1); 
        serverResponsePlainText += matchString;
        serverResponsePlainText += "\n";
    }
    return serverResponsePlainText;
}

/**
  * Connect method
  *
  * @param	int cuantos: Número de elementos ingresados por entrada estándar
  * @param char** argumentos: Elementos ingresados por entrada estándar
  * @param std::string figura: String con la figura solicitada por el usuario
  * @param std::string parte: Parte de la figura solicitada por el usuario
  * El método crea el socket cliente e interacciona con el servidor
  *
 **/
void conectar(int cuantos, char * argumentos[], std::string solicitud) {
   const char * requestMessage = "%s /%s/ ";
   char buf[100001];
   char clientRequest[ 100001 ] = { 0 };
   int bytes;
   char *hostname;
   // en hostname se almacena la ip ingresada
   hostname = argumentos[ 1 ];
   // Darle formato a la request. El resultado de amalgamar los strings se almacena en clientRequest
   sprintf( clientRequest, requestMessage, "GET", solicitud.c_str());
   // Revisar qué tipo de conexión se solicitó
   int puerto = PORT_INTER;
   std::string puertoString = std::to_string(puerto);
   VSocket * client;
   client = new Socket('s');
   // Crea una conexión TCP entre el socket y el servidor objetivo
   client->Connect(hostname, puertoString.c_str());
   // Enviar request al servidor
   client->Write(clientRequest, strlen( clientRequest ));
   memset(buf, 0, sizeof(buf));
   // Recibir response. Se almacena en el buffer buf
   bytes = client->Read( buf, sizeof( buf ));
   buf[ bytes ] = '\0';
   std::string buffer(buf);
   char* serverResponseHTML1 = new char[buffer.length() + 1];
   std::strcpy(serverResponseHTML1, buffer.c_str());
   // Printear la response del servidor
   std::string parsered = parserResponse(serverResponseHTML1);
   std::cout << parsered << std::endl;
   // Asignar 0 a cada elemento del buffer para resetearlo
   memset(buf, 0, sizeof(buf));
   
}

void menu(int cuantos, char * argumentos[]) {
   std::string entradaS;

   std::string espacio = " ";
   bool salir = false;
   while (!salir) {
      // pedir figura
      printf("Choose a figure:\n");
      printf("---------------\n");
      // Se lee la figura solicitada y se almacena en entradaS
      std::getline(std::cin, entradaS);
      // Chequeo de correctitud de la entrada (no puede haber espacios)
      size_t index_error = entradaS.find(espacio);
      if (std::string::npos != index_error) {
         std::cout << "Error: Invalid input. No spaces allowed." << std::endl;
      } else {
         conectar(cuantos, argumentos, entradaS);
         printf("---------------\n");
         // Revisar si se desea realizar más solicitudes
         printf("Continue? 1. Yes 2. No\n");
         std::getline(std::cin, entradaS);
         // Chequeo de correctitud de la entrada (solo dígitos de 1-2)
         if (entradaS == "1" || entradaS == "2") {
            while(entradaS != "1" && entradaS != "2") {
               // ver si debe continuar
               printf("---------------\n");
               printf("Continue? 1. Yes 2. No\n");
               printf("---------------\n");
               std::getline(std::cin, entradaS);
            }
            if(entradaS == "2"){
               salir = true;
            }
         } else {
            std::cout << "Error: Invalid input." << std::endl;
         }
      }
   }
}

// El main recibe por entrada estándar la ip de la computadora y el puerto al que el cliente se va a conectar
int main(int cuantos, char * argumentos[] ) { //ip port
   if ( cuantos != 2 ) {
      printf("usage: %s <hostname>\n", argumentos[0] );
      exit(0);
   } else {
      menu( cuantos, argumentos);  
   }
   return 0;
}

