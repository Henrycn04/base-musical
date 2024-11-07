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

#include <cstddef>
#include <stdexcept>
#include <cstdio>
#include <cstring>			// memset

#include <sys/socket.h>
#include <arpa/inet.h>			// ntohs
#include <unistd.h>			// close
//#include <sys/types.h>
#include <arpa/inet.h>
#include <netdb.h>			// getaddrinfo, freeaddrinfo

#include "VSocket.h"


/**
  *  Class initializer
  *     use Unix socket system call
  *
  *  @param     char t: socket type to define
  *     's' for stream
  *     'd' for datagram
  *  @param     bool ipv6: if we need a IPv6 socket
  *
 **/
void VSocket::InitVSocket( char t, bool IPv6 ){
int domain = 0;
this->IPv6 = IPv6;
 if(this->IPv6){
   domain = AF_INET6;

 }else{
   domain = AF_INET;
 } 
 if (t == 's'){
  idSocket = socket(domain, SOCK_STREAM , 0);
 }
 else if  (t == 'd'){
   idSocket = socket(domain, SOCK_DGRAM, 0);
 }
  if ( -1 == idSocket ) {
      throw std::runtime_error( "Socket::InitVSocket()" );
   } 

}

/**
  *  Class initializer
  *
  *  @param     int descriptor: socket descriptor for an already opened socket
  *
 **/
void VSocket::InitVSocket( int descriptor ) {

   this->idSocket = descriptor;

}

/**
  * Class destructor
  *
 **/
VSocket::~VSocket() {

   this->Close();

}


/**
  * Close method
  *    use Unix close system call (once opened a socket is managed like a file in Unix)
  *
 **/
void VSocket::Close(){
   int st = close(idSocket);

   if ( -1 == st ) {
      throw std::runtime_error( "Socket::Close()" );
   } 
    


}


/**
  * Connect method
  *   use "connect" Unix system call
  *
  * @param      char * host: host address in dot notation, example "10.1.104.187"
  * @param      int port: process address, example 80
  *
 **/
int VSocket::DoConnect( const char * hostip, int port ) {
   int st;
   if (this->IPv6){
          struct sockaddr_in6  host6;
            struct sockaddr * ha;

            memset( &host6, 0, sizeof( host6 ) );
            host6.sin6_family = AF_INET6;
            st = inet_pton( AF_INET6, hostip, &host6.sin6_addr );
            if ( -1 == st ) {	// 0 means invalid address, -1 means address error
               throw std::runtime_error( "Socket::Connect( const char *, int ) [inet_pton]" );
            }
            host6.sin6_port = htons( port );
            ha = (struct sockaddr *) &host6;
            socklen_t len = sizeof( host6 );
            st = connect( this->idSocket, ha, len );
            if ( -1 == st ) {
               throw std::runtime_error( "Socket::Connect( const char *, int ) [connect]" );
            }

   }
   else{

      struct sockaddr_in  host4;
      memset( (char *) &host4, 0, sizeof( host4 ) );
      host4.sin_family = AF_INET;
      st = inet_pton( AF_INET, hostip, &host4.sin_addr );
      if ( -1 == st ) {
         throw( std::runtime_error( "VSocket::DoConnect, inet_pton" ));
         }
      host4.sin_port = htons( port );
      st = connect( idSocket, (sockaddr *) &host4, sizeof( host4 ) );
      if ( -1 == st ) {
         throw( std::runtime_error( "VSocket::DoConnect, connect" ));
      }
   }
   return st;

}


/**
  * DoConnect method
  *   use "connect" Unix system call
  *
  * @param      const char * host: host address 
  * @param      const char * service, service name, example "http"
  *
 **/
int VSocket::DoConnect( const char * hostip, const char * service ) {
   int st;
        struct addrinfo hints, *result, *rp;

         memset(&hints, 0, sizeof(struct addrinfo));
         hints.ai_family = AF_UNSPEC;    /* Allow IPv4 or IPv6 */
         hints.ai_socktype = SOCK_STREAM; /* Stream socket */
         hints.ai_flags = 0;
         hints.ai_protocol = 0;          /* Any protocol */

         st = getaddrinfo( hostip, service, &hints, &result );

         for ( rp = result; rp; rp = rp->ai_next ) {
            st = connect( idSocket, rp->ai_addr, rp->ai_addrlen );
            if ( 0 == st )
               break;
         }

         freeaddrinfo( result );



   if ( -1 == st ) {
      perror( "VSocket::connect" );
      throw std::runtime_error( "VSocket::DoConnect" );
   }

   return st;

}


/**
  * Listen method
  *
  * @param      int queue: max pending connections to enqueue (server mode)
  *
  *  This method define how many elements can wait in queue
  *
 **/
int VSocket::Listen( int queue ) {
   int st = listen(this->idSocket, queue);

   if ( -1 == st ) {
      throw std::runtime_error( "VSocket::Listen( int )" );
   }

   return st;

}

/**
  * Bind method
  *    use "bind" Unix system call (man 3 bind) (server mode)
  *
  * @param      int port: bind a unamed socket to a port defined in sockaddr structure
  *
  *  Links the calling process to a service at port
  *
 **/
int VSocket::Bind( int port ) {
   int opt = 1;
    if (setsockopt(this->idSocket, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
        throw( std::runtime_error( "VSocket::Bind, error at reuse addr" ));
        return 1;
    }
   int st = -1;
   if (this->IPv6){
        struct sockaddr_in6  host6;
     
      memset(&host6, 0, sizeof( host6 ) );
      host6.sin6_family = AF_INET6;
      host6.sin6_port = htons( port );
      host6.sin6_addr = in6addr_any; 
    
      st = bind( idSocket, (sockaddr*) &host6, sizeof(host6) );
      if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::Bind, bind" ));
   }

   }else{
   struct sockaddr_in  host4;
    memset( (char *) &host4, 0, sizeof( host4 ) );
   host4.sin_family = AF_INET;
   host4.sin_addr.s_addr = htonl( INADDR_ANY );
   host4.sin_port = htons( port );
   memset(host4.sin_zero, '\0', sizeof (host4.sin_zero)); 

   st = bind( idSocket, (sockaddr *) &host4, sizeof( host4 ) );
   if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::Bind, bind" ));
   }
   }

   return st;

}

/**
  * DoAccept method
  *    use "accept" Unix system call (man 3 accept) (server mode)
  *
  *  @returns   a new class instance
  *
  *  Waits for a new connection to service (TCP mode: stream)
  *
 **/
int VSocket::DoAccept(){
   int st=-1;
 if (this->IPv6){
        struct sockaddr_in6  host6;
     
      memset(&host6, 0, sizeof( host6 ) );
      host6.sin6_family = AF_INET6;
      host6.sin6_port = htons( port );
      host6.sin6_addr = in6addr_any; 

      socklen_t len = sizeof( host6 );
      st = accept(this->idSocket, (sockaddr *) &host6, &len );
    
      if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::DoAccept()" ));
   }

   }else{

    struct sockaddr_in  host4;
    memset( (char *) &host4, 0, sizeof( host4 ) );
   host4.sin_family = AF_INET;
   host4.sin_addr.s_addr = htonl( INADDR_ANY );
   host4.sin_port = htons( port );
   memset(host4.sin_zero, '\0', sizeof (host4.sin_zero)); 
   socklen_t len = sizeof( host4 );
   st = accept(this->idSocket, (sockaddr *) &host4, &len );
    
   if ( -1 == st ) {
      throw std::runtime_error( "VSocket::DoAccept()" );
   }
   }

   return st;

}


/**
  * Shutdown method
  *    use "shutdown" Unix system call (man 3 shutdown)
  *
  *  @param	int mode define how to cease socket operation
  *
  *  Partial close the connection (TCP mode)
  *
 **/
int VSocket::Shutdown( int mode ) {
   int st = shutdown(this->idSocket, mode);

   if ( -1 == st ) {
      throw std::runtime_error( "VSocket::Shutdown( int )" );
   }

   return st;

}

/**
  *  sendTo method
  *
  *  @param	const void * buffer: data to send
  *  @param	size_t size data size to send
  *  @param	void * addr address to send data
  *
  *  Send data to another network point (addr) without connection (Datagram)
  *
 **/
size_t VSocket::sendTo( const void * buffer, size_t size, void * addr ) {
   int st = -1;
   if(this->IPv6){
     sockaddr_in6* addr1 = (sockaddr_in6*)addr;
     socklen_t len = sizeof(sockaddr_in6);
     st = sendto(this->idSocket, buffer, size, 0, (sockaddr *) addr1, len);
     if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::sendTo, sendto" ));
   }

   } else{
   sockaddr_in* addr1 = (sockaddr_in*)addr;
   socklen_t len = sizeof(sockaddr_in);
   st = sendto(this->idSocket, buffer, size, 0, (sockaddr *) addr1, len);
  if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::sendTo, sendto" ));
   }
   }
   return st;

}


/**
  *  recvFrom method
  *
  *  @param	const void * buffer: data to send
  *  @param	size_t size data size to send
  *  @param	void * addr address to receive from data
  *
  *  @return	size_t bytes received
  *
  *  Receive data from another network point (addr) without connection (Datagram)
  *
 **/
size_t VSocket::recvFrom( void * buffer, size_t size, void * addr ) {
     int st = -1;
   if(this->IPv6){
     sockaddr_in6* addr1 = (sockaddr_in6*)addr;
     socklen_t len = sizeof(sockaddr_in6);
     st = recvfrom(this->idSocket, buffer, size, 0, (sockaddr *) addr1, &len);
     if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::recvFrom, recvFrom" ));
   }

   } else{
      sockaddr_in* addr1 = (sockaddr_in*)addr;
      socklen_t len = sizeof(sockaddr_in);
      //int flags = fcntl(this->idSocket, F_GETFL, 0);
      st = recvfrom(this->idSocket, buffer, size, 0, (sockaddr *) addr1, &len);
      /*if ( -1 == st ) {
            throw( std::runtime_error( "VSocket::recvFrom, recvFrom" ));
         }*/
   }

   return st;

}

size_t VSocket::recvFromNoWait( void * buffer, size_t size, void * addr ) {
     int st = -1;
   if(this->IPv6){
     sockaddr_in6* addr1 = (sockaddr_in6*)addr;
     socklen_t len = sizeof(sockaddr_in6);
     st = recvfrom(this->idSocket, buffer, size, 0, (sockaddr *) addr1, &len);
     if ( -1 == st ) {
      throw( std::runtime_error( "VSocket::recvFrom, recvFrom" ));
   }

   } else{
      sockaddr_in* addr1 = (sockaddr_in*)addr;
      socklen_t len = sizeof(sockaddr_in);
      //int flags = fcntl(this->idSocket, F_GETFL, 0);
      st = recvfrom(this->idSocket, buffer, size, MSG_DONTWAIT, (sockaddr *) addr1, &len);
      /*if ( -1 == st ) {
            throw( std::runtime_error( "VSocket::recvFrom, recvFrom" ));
         }*/
   }

   return st;

}
