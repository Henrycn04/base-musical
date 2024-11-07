#include <iostream>
#include <fstream>
#include <string>
#include <thread>
#include <map>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <cstring>
#include <filesystem>

// Puerto para el servidor HTTP
#define PORT_HTTP 80

void handleRequest(int clientSocket) {
    std::cout << "Cliente: " << clientSocket << std::endl;
    char buffer[1024] = {0};
    read(clientSocket, buffer, 1024);

    std::string request(buffer);
    std::string method = request.substr(0, request.find(" "));
    std::string path = request.substr(request.find(" ") + 1, request.find(" ", request.find(" ") + 1) - request.find(" ") - 1);

    std::string response;
    std::string contentType;
    
    // Sirviendo el archivo solicitado
    if (path == "/") path = "/index.html";
    std::string filePath = "." + path;

    if (std::filesystem::exists(filePath)) {
        std::ifstream file(filePath, std::ios::binary);
        std::stringstream buffer;
        buffer << file.rdbuf();
        std::string content = buffer.str();

        if (filePath.find(".html") != std::string::npos) {
            contentType = "text/html";
        } else if (filePath.find(".mp3") != std::string::npos) {
            contentType = "audio/mpeg";
        }

        response = "HTTP/1.1 200 OK\nContent-Type: " + contentType + "\nContent-Length: " + std::to_string(content.size()) + "\n\n" + content;
    } else {
        response = "HTTP/1.1 404 NOT FOUND\nContent-Type: text/plain\n\nFile Not Found";
    }

    send(clientSocket, response.c_str(), response.size(), 0);
    close(clientSocket);
}

void startHttpServer() {
    int serverFd, newSocket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);

    if ((serverFd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("Socket failed");
        exit(EXIT_FAILURE);
    }

    if (setsockopt(serverFd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))) {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT_HTTP);

    if (bind(serverFd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }

    if (listen(serverFd, 10) < 0) {
        perror("Listen");
        exit(EXIT_FAILURE);
    }

    while (true) {
        if ((newSocket = accept(serverFd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) {
            perror("Accept");
            exit(EXIT_FAILURE);
        }
        std::thread(handleRequest, newSocket).detach();
    }
}

int main(int argc, char const *argv[]) {
    std::thread httpServer(startHttpServer);
    httpServer.join();
    return 0;
}
