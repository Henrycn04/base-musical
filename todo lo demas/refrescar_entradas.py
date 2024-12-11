from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time

# Configura las opciones de Chrome
options = webdriver.ChromeOptions()
options.add_argument("--user-data-dir=C:/Users/XPC/AppData/Local/Google/Chrome/User Data")  # Ruta a tu perfil
options.add_argument("--profile-directory=Default")  # O el nombre de tu perfil
options.add_argument("--remote-debugging-port=9222")  # Habilita el puerto de depuración
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-extensions")
options.add_argument("--disable-gpu")

# Inicia Chrome con el perfil especificado
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

# URL del sitio donde comprar las entradas
url = "https://www.instagram.com/artcitytour/"

# Abre la página
driver.get(url)

# Automáticamente refresca la página cada 10 segundos
while True:
    time.sleep(10)  # Espera 10 segundos
    driver.refresh()  # Refresca la página
    print("Refrescando página...")  # Muestra un mensaje en consola
