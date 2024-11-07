<template>
    <div class="page-container">
        <header class="encabezado-sitio" :class="{ 'menu-fixed': isFixed }">
            <div class="menu-hamburguesa">
            <a href="#" class="hamburguesa" @click.prevent="toggleMenu">
                <i class="fa fa-bars" aria-hidden="true"></i></a>
            </div>
            <div class="logos">
            <div class="logo-ucr">
                <a href="https://ucr.ac.cr" target="_blanck">
                <img src="https://artesmusicales.ucr.ac.cr/wp-content/themes/artesmusicales/img/logo-ucr.png" class="logotipo">
                </a>
            </div><!--.logo-ucr-->
                <div class="logo">
                <a href="https://artesmusicales.ucr.ac.cr/">
                <img src="https://artesmusicales.ucr.ac.cr/wp-content/themes/artesmusicales/img/logo-eam.png" class="logotipo">
                </a>
                </div><!--.logo-eam-->
            </div><!--.logos-->
        </header>
        <div class="contenedor navegacion">
            <div id="back_menu" v-show="menuVisible" @click="toggleMenu" class="back-menu"></div>
            <nav class="menu-sitio" v-show="menuVisible">
                <a href="https://artesmusicales.ucr.ac.cr/">
                    <img src="https://artesmusicales.ucr.ac.cr/wp-content/themes/artesmusicales/img/logo-eam.png" class="logotipo logo-menu">
                </a>
                <div class="menu-principal-container">
                    <ul id="menu-principal" class="menu">
                        <li id="menu-item-44" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-home menu-item-44">
                            <a href="https://artesmusicales.ucr.ac.cr/">Inicio</a>
                        </li>
                        <li id="menu-item-479" class="menu-item menu-item-type-custom menu-item-object-custom current-menu-ancestor current-menu-parent menu-item-has-children menu-item-479">
                            <a href="#">Acerca de</a>
                            <ul class="sub-menu">
                                <li id="menu-item-484" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-484">
                                    <a href="https://artesmusicales.ucr.ac.cr/historia/">Historia</a>
                                </li>
                                <li id="menu-item-485" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-485">
                                    <a href="https://artesmusicales.ucr.ac.cr/mision-y-vision-2/">Misión y Visión</a>
                                </li>
                                <li id="menu-item-576" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-576">
                                    <a href="https://artesmusicales.ucr.ac.cr/direccion-de-la-eam/">Dirección de la EAM</a>
                                </li>
                                <li id="menu-item-486" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-486">
                                    <a href="https://artesmusicales.ucr.ac.cr/personal-administrativo/">Personal administrativo</a>
                                </li>
                                <li id="menu-item-480" class="menu-item menu-item-type-post_type menu-item-object-page current-menu-item page_item page-item-294 current_page_item menu-item-480">
                                    <a href="https://artesmusicales.ucr.ac.cr/archivo-historico-musical/" aria-current="page">Archivo Histórico Musical</a>
                                </li>
                                <li id="menu-item-481" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-481">
                                    <a href="https://artesmusicales.ucr.ac.cr/biblioteca-de-artes-musicales/">Biblioteca de Artes Musicales</a>
                                </li>
                                <li id="menu-item-482" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-482">
                                    <a href="https://artesmusicales.ucr.ac.cr/contacto/">Contacto</a>
                                </li>
                                <li id="menu-item-483" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-483">
                                    <a href="https://artesmusicales.ucr.ac.cr/galeria-eam/">Galería EAM</a>
                                </li>
                            </ul>
                        </li>
                        <li id="menu-item-17" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-17">
                            <a href="#">Admisión</a>
                            <ul class="sub-menu">
                                <li id="menu-item-886" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-886">
                                    <a href="https://artesmusicales.ucr.ac.cr/etapauniversitaria/">Etapa Universitaria</a>
                                </li>
                                <li id="menu-item-638" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-638">
                                    <a href="https://artesmusicales.ucr.ac.cr/programa-preuniversitario/">Programa preuniversitario</a>
                                </li>
                            </ul>
                        </li>
                        <li id="menu-item-487" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-487">
                            <a href="#">Asuntos Estudiantiles</a>
                            <ul class="sub-menu">
                                <li id="menu-item-488" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-488">
                                    <a href="#">Estudiar en la EAM</a>
                                </li>
                                <li id="menu-item-489" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-489">
                                    <a href="https://artesmusicales.ucr.ac.cr/asociacion-de-estudiantes/">Asociación de estudiantes</a>
                                </li>
                                <li id="menu-item-491" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-491">
                                    <a href="https://artesmusicales.ucr.ac.cr/normativa-estudiantil/">Normativa estudiantil</a>
                                </li>
                                <li id="menu-item-490" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-490">
                                    <a href="https://artesmusicales.ucr.ac.cr/horas-estudiante/">Horas estudiante</a>
                                </li>
                                <li id="menu-item-665" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-665">
                                    <a href="https://artesmusicales.ucr.ac.cr/documentos_asuntos_estudiantiles/">Documentos</a>
                                </li>
                            </ul>
                        </li>
                        <li id="menu-item-492" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-492">
                            <a href="#">Vida Académica</a>
                            <ul class="sub-menu">
                                <li id="menu-item-493" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-493">
                                    <a href="https://artesmusicales.ucr.ac.cr/personal-docente/">Personal docente</a>
                                </li>
                                <li id="menu-item-495" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-495">
                                    <a href="https://artesmusicales.ucr.ac.cr/musica-en-la-comunidad/">Música en la comunidad</a>
                                </li>
                                <li id="menu-item-494" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-494">
                                    <a href="#">Acción Social</a>
                                </li>
                                <li id="menu-item-498" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-498">
                                    <a href="https://artesmusicales.ucr.ac.cr/investigacion/">Investigación</a>
                                </li>
                            </ul>
                        </li>
                        <li id="menu-item-497" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-497">
                            <a href="https://artesmusicales.ucr.ac.cr/eventos-eam/">Eventos EAM</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <h1 style="color:black; text-align: center; background-color: #89D0D1;">Base Musical Latinoamericana</h1>
        <main class="main-content">
            <div class="main-content2">
                <div class="filters" style="font-family: 'League Spartan', sans-serif;">
                <h2>Filtros</h2>
                <label for="companies">Categorias iniciales:</label>
                    <div v-for="category in categoriasIniciales" :key="category.id" style="margin-top: 5px;">
                        <input type="checkbox" :id="category.id" :value="category.id" v-model="categoriasSeleccionadas" @change="fetchCategories"/>
                        <label :for="category.id">   &nbsp; {{ category.nombre }}</label>
                    </div> 
                    <div class="dropdown">
                        <button style="background-color: #9b6734"> Categorias iniciales ▼</button>
                        <div class="dropdown-content">
                            <a v-for="category in categoriasIniciales" :key="category.id" href="#">
                                {{ category.nombre }}
                            </a>
                        </div>
                    </div>
                <label for="companies">Categorias secundarias:</label>
                    <div v-for="category in categoriasEncontradas" :key="category.id" style="margin-top: 5px;">
                        <input type="checkbox" :id="category.id" :value="category.id" v-model="categoriasSeleccionadas"  @change="fetchCategories"/>
                        <label :for="category.id">   &nbsp; {{ category.nombre }}</label>
                    </div>                                          
                </div>
                    <div class="inventory">
                    <!-- Aquí van los items del inventario -->
  <!--                     <div v-if="loading">Cargando...</div>
                  <div v-else style="font-family: 'League Spartan', sans-serif;">
                        <div v-for="item in items" :key="item.id" class="item-card">
                        <img :src="item.imagenURL" alt="Imagen del producto" />
                        <h3>{{ item.nombreProducto }}</h3>
                        <p>{{ item.descripcion }}</p>
                        <p>Precio: {{ item.precio }}</p>
                        </div>
                    </div> -->
                </div>
            </div>
        </main>
        <footer class="footer">
            <p style="display: block;text-align: center; font-family: 'Poppins', sans-serif; font-size: medium;"> &copy; Universidad de Costa Rica - Escuela de Artes Musicales © 2024 </p>
        </footer>
    </div>
</template>





<script>
import axios from 'axios';
    export default {
    data() {
        return {
        menuVisible: false,
        subMenuVisible: {
            acercaDe: false,
        },
        isFixed: false,
        categoriasIniciales: [],
        categoriasSeleccionadas: [],
        categoriasEncontradas: [],
        };
    },
    created() {
            this.fetchStart();
        },
    methods: {
        toggleMenu() {
        this.menuVisible = !this.menuVisible;
        },
        toggleSubMenu(menu) {
        this.subMenuVisible[menu] = !this.subMenuVisible[menu];
        },
        handleScroll() {
        this.isFixed = window.scrollY > this.$el.offsetTop;
        },
        async fetchStart() {
            axios.get('https://localhost:7029/api/categorias/sin-padre')
                .then((response) => {
                    this.categoriasIniciales = response.data;
                    console.log('Categorias iniciales:', this.categoriasIniciales);
                })
                .catch((error) => {
                    console.error('Error fetching.', error);
                });
        },
        async fetchCategories() { // este es para traerme los ejemplos
            this.loading = true;
            try {
                // Realiza ambas peticiones en paralelo, incluyendo el rango de precios y las empresas seleccionadas
                const params = { padres: this.categoriasSeleccionadas };

                console.log('Categorias SELECCIONADAS:', this.categoriasSeleccionadas);

                // Asegúrate de que `categoriasSeleccionadas` esté actualizado con un pequeño retraso
                setTimeout(() => {
                    axios.get('https://localhost:7029/api/categorias/por-padre', {
                        params,
                        paramsSerializer: (params) => {
                            return Object.entries(params)
                                .map(([key, value]) =>
                                    Array.isArray(value)
                                        ? value.map(val => `${encodeURIComponent(key)}=${encodeURIComponent(val)}`).join('&')
                                        : `${encodeURIComponent(key)}=${encodeURIComponent(value)}`
                                )
                                .join('&');
                        }
                    }).then((response) => {
                        this.categoriasEncontradas = response.data;
                        console.log('Categorias secundarias:', response.data);
                    })
                    .catch((error) => {
                        console.error('Error fetching.', error);
                    });
                }, 0);

            } catch (error) {
                console.error('Error al filtrar productos:', error);
            } finally {
                this.loading = false;
            }
        },
        async fetchExamples() { // este es para traerme los ejemplos
                this.loading = true;
                try {
                    // Realiza ambas peticiones en paralelo, incluyendo el rango de precios y las empresas seleccionadas
                    const params = {
                        categoria: this.selectedCategory,
                        precioMin: this.priceRange[0],
                        precioMax: this.priceRange[1],
                        empresas: this.selectedCompanies // Asigna el array directamente
                    };

                    // Configura axios para usar un serializador personalizado
                    await axios.get('https://localhost:7029/api/categorias', {
                        params,
                        paramsSerializer: (params) => {
                            return Object.keys(params)
                                .map(key => 
                                    Array.isArray(params[key]) 
                                        ? params[key].map(val => `${encodeURIComponent(key)}=${encodeURIComponent(val)}`).join('&') 
                                        : `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`
                                )
                                .join('&');
                        }
                    });

                    await axios.get('https://localhost:7029/api/products/perishable', {
                        params,
                        paramsSerializer: (params) => {
                            return Object.keys(params)
                                .map(key => 
                                    Array.isArray(params[key]) 
                                        ? params[key].map(val => `${encodeURIComponent(key)}=${encodeURIComponent(val)}`).join('&') 
                                        : `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`
                                )
                                .join('&');
                        }
                    });

                } catch (error) {
                    console.error('Error al filtrar productos:', error);
                } finally {
                    this.loading = false;
                }
            },
    },
    watch: {
            selectedCategory() {
                this.fetchItems();
            },
        },
    mounted() {
        document.addEventListener('click', this.handleClickOutside);
        window.addEventListener('scroll', this.handleScroll);
    },
    beforeUnmount() {
        window.removeEventListener('scroll', this.handleScroll);
    },
    };
</script>




<style scoped>
    html, body {
        margin: 0;
        padding: 0;
        height: 100%;
        background-color: white;
    }

    .page-container {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }



    .main-content {
        background-color: #ffeec2;
        flex: 1;
    }
    .subheader {
        list-style-type: none;
        display: flex;
        margin: 0;
        padding: 0;
        align-items: center;
        padding: 10px 20px;
        background-color: #d57623;
        font-family: 'League Spartan', sans-serif;
        max-width: 100vw;
        text-decoration: none;
    }
    .subheader a{
        color: #463a2e;
        text-decoration: none;
        margin-right: 15px;
        font-weight: bold;
    }
    header.encabezado-sitio div div {
  display:inline-block;
}
.menu-hamburguesa {
  float: left;
}
.menu-hamburguesa a{
  text-decoration: none;
  color: #000000;
}
.hamburguesa {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 85px;
  height: 85px;
  background-color: #89D0D1;
  font-size: 30px;
  cursor: pointer;
  transition: all 300ms;
}
.hamburguesa:hover{
  background-color: rgba(137, 208, 209, 0.5);
}
.logos{
  text-align: right;
  height: 85px;
}
img.logotipo {
  width: 200px;
}

@media only screen and (max-width:768px){ /** Centra el logo para telefonos**/
  header.encabezado-sitio div.logos {
    text-align: center;
  }
}

@media only screen and (max-width:768px){ /** Desaparece el logo-ucr**/
  header.encabezado-sitio div div.logo-ucr {
  display: none;
  }
}
.dropdown {
        position: relative;
        display: inline-block;
    }



    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 1;
    }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .main-content2 {
    display: flex;
    margin: 20px;
    }

    .filters {
    width: 25%;
    padding: 10px;
    border-right: 1px solid #ddd;
    }

    .inventory {
    width: 75%;
    padding: 10px;
    }

    .footer {
        display: block;
        justify-content: space-between;
        background-color: #9b6734;
        color: #f2f2f2;
    }
</style>
