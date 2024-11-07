/**
 *  Establece la definición de la clase Socket para efectuar la comunicación
 *  de procesos que no comparten memoria, utilizando un esquema de memoria
 *  distribuida.  El desarrollo de esta clase se hará en varias etapas, primero
 *  los métodos necesarios para los clientes, en la otras etapas los métodos para el servidor,
 *  manejo de IP-v6, conexiones seguras y otros
 *
 *  Universidad de Costa Rica
 *  ECCI
 *  CI0123 Proyecto integrador de redes y sistemas operativos
 *  2023-ii
 *  Grupos: 2 y 3
 *
 * (versión Fedora)
 *
 **/

#ifndef Socket_h
#define Socket_h
#include <openssl/ssl.h>
#include <openssl/err.h>

#include "VSocket.h"

class Socket : public VSocket {

   public:
      Socket( char, bool = false );
       Socket( int );
      ~Socket();
      void Close();
      int Connect( const char *, int );
      int Connect( const char *, const char * );
      size_t Read(void *, size_t );
      size_t Write( const void *, size_t );
      size_t Write( const char * );
      Socket * Accept();
      const char * SSLGetCipher();
      void SSLCreate( Socket * );
      void SSLAccept();
      void SSLShowCerts();
      size_t SSLRead( void *, size_t );
      size_t SSLWrite( const void *, size_t );   
      void SSLInitServer( const char *, const char *); 
      void SSLInit();
      int SSLConnect( const char * hostName, int port );
      void SSLInitServerContext();

   protected:
   private:     
   void SSLLoadCertificates( const char * , const char * );

   void SSLInitContext(); 
  
   // Instance variables      
      void * SSLContext;					// SSL context
      void * SSLStruct;					// SSL BIO (Basic Input/Output)

};

#endif

