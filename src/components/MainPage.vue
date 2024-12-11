<template>
  <div class="music-filter d-flex flex-column min-vh-100">
    <!-- Header con imágenes y título -->
    <header class="d-flex align-items-center justify-content-between w-100">
      <!-- Texto en vertical -->
      <div class="d-flex flex-column">
        <h1 >Latinoamérica en la clase de Teoría y Análisis Musical (La-TAM)</h1>
        <h7 >Repositorio de extractos musicales de compositorxs latinoamericanxs para cursos universitarios de armonía y conducción de voces</h7>
      </div>

      <!-- Imágenes alineadas horizontalmente a la derecha -->
      <div class="d-flex">
        <a href="https://www.ucr.ac.cr/" target="_blank">
          <img 
            src="https://artesmusicales.ucr.ac.cr/wp-content/themes/artesmusicales/img/logo-ucr.png" 
            alt="Logo UCR" 
            style="width: 150px; height: 150px; object-fit: contain;"
          >
        </a>
        <a href="https://artesmusicales.ucr.ac.cr/" target="_blank">
          <img 
            src="https://artesmusicales.ucr.ac.cr/wp-content/themes/artesmusicales/img/logo-eam.png" 
            alt="Logo Escuela de Artes Musicales" 
            style="width: 150px; height: 150px; object-fit: contain; margin-left: 10px;"
          >
        </a>
      </div>
    </header>

    <!-- Subheader -->
    <div class="d-flex align-items-center bg-primary text-white py-2 px-3" style="width: 100%; font-family: 'Poppins', sans-serif;">
      <a href="https://docs.google.com/forms/d/e/1FAIpQLSc1_q36_CQX5271lb_uSWkvj-KDsKP7R9zJ4Sb8-zzlwWMcHQ/viewform?usp=sharing" 
        class="text-decoration-none text-white"
        target="_blank">
        Contribuir ejemplos
      </a>
    </div>

    <div class="row mt-4">
      <!-- Columna izquierda (filtros y elementos seleccionados) -->
      <div class="col-md-3" style="padding-left: 20px;">

        <div class="dynamic-tree">
          <h3 class="text-primary">Filtros</h3>
          <el-tree
            ref="tree"
            :data="musicalOptions2"
            :props="defaultProps"
            :check-strictly="true"
            :default-expand-all="false"
            show-checkbox
            @check="handleCheck"
            class="tree-select"
          >
        </el-tree>
        </div>
        <div v-if="selectedItems.length > 0" class="mb-4">
          <h5 class="text-primary">Elementos seleccionados:</h5>
          <ul class="list-group">
            <li
              v-for="item in selectedItems"
              :key="item"
              class="list-group-item d-flex justify-content-between align-items-center"
            >
              {{ item }}
              <span 
                class="badge bg-danger text-white" 
                style="cursor: pointer;" 
                @click="removeSelectedItem(item)"
              >✖</span>
            </li>
          </ul>
        </div>
      </div>

      <!-- Columna derecha (Ejemplos encontrados) -->
      <div class="col-md-9">
        <div v-if="examples.length > 0">
          <h3 class="text-primary">Ejemplos encontrados</h3>
          <ul class="list-group">
            <li
              v-for="example in examples"
              :key="example.id"
              class="list-group-item d-flex justify-content-between align-items-center"
            >
              <!-- Contenedor para el nombre y la descripción -->
              <div class="example-title-container">
                <strong class="example-title">{{ example.nombre }}</strong>
              </div>

              <!-- Contenedor para los botones y el reproductor de audio -->
              <div class="d-flex align-items-center gap-2 button-group">
                <button
                  v-if="getFileType(example.imagen) === 'image'"
                  class="btn btn-info btn-standard"
                  @click="openModal(example.imagen)"
                >
                  Ver Partitura
                </button>
                <a 
                  :href="example.partitura"
                  class="btn btn-success btn-standard"
                  download
                >
                  Descargar partitura
                </a>
                <audio controls class="ms-3" :src="example.rutaArchivo">
                  Your browser does not support the audio element.
                </audio>
              </div>
            </li>
          </ul>
        </div>

        <div v-else>
          <h3 class="text-muted">No hay ejemplos disponibles.</h3>
        </div>
      </div>
    </div>

    <!-- Modal para la partitura -->
    <div class="modal fade" id="partituraModal" tabindex="-1" aria-labelledby="partituraModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="partituraModalLabel">Partitura</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div v-if="fileType === 'image'" class="image-container">
              <img :src="fileUrl" alt="Partitura" class="partitura-image">
            </div>
            <div v-else-if="fileType === 'pdf'">
              <embed :src="fileUrl" width="100%" height="500px" type="application/pdf">
            </div>
          </div>
          <div class="modal-footer">
            <a :href="fileUrl" class="btn btn-success" download>Descargar</a>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>
    <footer class="text-center py-3 bg-light border-top" style="margin-top: 150px;">
      <small class="text-muted">@UCR 2024</small>
    </footer>
  </div>
  
</template>


<script>
//import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';

export default {
  name: "MusicFilter",
  data() {
    return {
      examples: [],
      selectedItems: [],
      musicalOptions2: [],
      
      ejemplos: [],
      musicalCategories: [],
      ejemploCategoria:[],

      fileUrl: '',
      fileType: ''
    };
  },
  computed: {
    defaultProps() {
      return {
        children: 'children',
        label: 'label',
        value: 'value',
      };
    }
  },
  methods: {
    renderContent(h, { data }) {
      return h(
        "span",
        {
          style: {
            marginTop: "10px",  // Espaciado superior
            marginBottom: "10px",  // Espaciado inferior
          }
        },
        data.label
      );
    },

  openModal(imagen) {
        // Determinar el tipo de archivo (imagen o PDF)
        this.fileUrl = imagen;
        this.fileType = this.getFileType(imagen);

        // Mostrar el modal
        if (typeof bootstrap !== 'undefined') {
          // eslint-disable-next-line no-undef
          const modal = new bootstrap.Modal(document.getElementById('partituraModal'));
          modal.show();
        } else {
          console.error('Bootstrap no está disponible');
        }
        
      },
      getFileType(url) {
        // Verificar si el archivo es una imagen o un PDF según su extensión
        if (url.endsWith('.pdf')) {
          return 'pdf';
        } else if (url.endsWith('.jpg') || url.endsWith('.jpeg') || url.endsWith('.png') || url.endsWith('.gif')) {
          return 'image';
        } else {
          return 'unknown'; // Caso por defecto
        }
      },
  handleCheck() {
      // Obtiene todos los nodos seleccionados
      const checkedNodes = this.$refs.tree.getCheckedNodes();

      // Actualiza el array con los labels de los nodos seleccionados
      this.selectedItems = checkedNodes.map(node => node.label);

      console.log("Elementos seleccionados:", this.selectedItems);
      this.fetchExamples();
    },
    removeSelectedItem(item) {
      // Buscar el nodo con el valor correspondiente en el árbol
      const node = this.findNodeByLabel(this.musicalOptions2, item);
      
      if (node) {
        // Desmarca el nodo encontrado
        this.$refs.tree.setChecked(node, false, true);
      }

      // Remueve el item de la lista de elementos seleccionados
      const index = this.selectedItems.indexOf(item);
      if (index !== -1) {
        this.selectedItems.splice(index, 1);
        console.log("Elementos seleccionados:", this.selectedItems);
        this.fetchExamples();
      }
    },
    // Función recursiva para encontrar el nodo por label
    findNodeByLabel(treeData, label) {
      for (const node of treeData) {
        if (node.label === label) {
          return node;
        }
        if (node.children && node.children.length) {
          const foundNode = this.findNodeByLabel(node.children, label);
          if (foundNode) {
            return foundNode;
          }
        }
      }
      return null;
    },
    async  obtenerEjemplosPorCategorias(categoriaLabels, ejemplos, asociaciones, categorias) {
      let resultado = [];

      // Caso cuando no se seleccionan categorías o la lista está vacía
      if (!categoriaLabels || categoriaLabels.length === 0) {
        resultado = ejemplos;
      } else {
        const recursiveCategories = [];

        // Obtener IDs de categorías seleccionadas
        const selectedCategoryIds = categorias
          .filter((categoria) => categoriaLabels.includes(categoria.name))
          .map((categoria) => categoria.id);
        // Iniciar la búsqueda recursiva
        this.buscarCategoriasRecursivas(selectedCategoryIds, categorias, recursiveCategories);

        // Obtener los ejemploIds de las asociaciones que coinciden con las categorías encontradas
        const ejemploIds = asociaciones
          .filter((asociacion) => recursiveCategories.includes(asociacion.categoriaId))
          .map((asociacion) => asociacion.ejemploId);

        // Filtrar ejemplos que coinciden con los ejemploIds
        resultado = ejemplos.filter((ejemplo) => ejemploIds.includes(ejemplo.id));
      }

      return resultado;
    },
    buscarCategoriasRecursivas(ids, categorias, recursiveCategories) {
      ids.forEach((id) => {
        if (!recursiveCategories.includes(id)) {
          recursiveCategories.push(id);
          const hijos = categorias.filter((categoria) => categoria.parentId === id);
          this.buscarCategoriasRecursivas(hijos.map((hijo) => hijo.id), categorias, recursiveCategories);
        }
      });
    },

    async fetchExamples() {

      try {
            console.log("Categorías enviadas:", this.selectedItems); // Verifica qué categorías estás enviando
            // Prepara los parámetros para la solicitud
            /*const params = {
                categorias: this.selectedItems // Asegúrate de que selectedItems sea un array
            };

            const response = await axios.get('https://basemusicallatina-g5cyh2eddmfzgqd4.eastus2-01.azurewebsites.net/api/MusicalCategories/GetExamples', {
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
            console.log("Respuesta de la API:", response.data); // Verifica la respuesta de la API 

            this.examples = response.data; // Asigna los ejemplos obtenidos a la variable de datos*/
            this.examples = await this.obtenerEjemplosPorCategorias(this.selectedItems, this.ejemplos, this.ejemploCategoria, this.musicalCategories);

            console.log("Ejemplos obtenidos:", this.examples); // Verifica la asignación
        } catch (error) {
            console.error("Error al obtener ejemplos:", error);
        }
        }
      },
  async mounted() {
    this.musicalOptions2 = [ { "Id": 1, "label": "Escalas", "children": [ { "Id": 14, "label": "1. Pentatónicas", "children": [ { "Id": 20, "label": "1.1. Modo I (mayor): 1 2 3 5 6" }, { "Id": 21, "label": "1.2. Modo II: 1 2 4 5 ♭7" }, { "Id": 22, "label": "1.3. Modo III: 1 ♭3 4 ♭6 ♭7" }, { "Id": 23, "label": "1.4. Modo IV: 1 2 4 5 6" }, { "Id": 24, "label": "1.5. Modo V (menor): 1 ♭3 4 5 ♭7" } ] }, { "Id": 15, "label": "2. Hexatónicas", "children": [ { "Id": 25, "label": "2.1. Tonos enteros (Modo I de transposición limitada, Messian)", "children": [ { "Id": 26, "label": "2.1.1. TE0 (0-2-4-6-8-10)" }, { "Id": 27, "label": "2.1.2. TE1 (1-3-5-7-9-11)" } ] }, { "Id": 28, "label": "2.2. Escala de blues (1 b3 4 #4/♭5 5 ♭7)" }, { "Id": 29, "label": "2.3. Aumentada", "children": [ { "Id": 30, "label": "2.3.1. HEX 0,1 (0-1-4-5-8-9)" }, { "Id": 31, "label": "2.3.2. HEX 1,2 (1-2-5-6-9-10)" }, { "Id": 32, "label": "2.3.3. HEX 2,3 (2-3-6-7-10-11)" }, { "Id": 33, "label": "2.3.4. HEX 3,4 (3-4-7-8-11-0)" } ] }, { "Id": 34, "label": "2.4. Modo de transposición limitada V, Messian (0-1-5-6-7-11)" } ] }, { "Id": 16, "label": "3. Heptatónicas", "children": [ { "Id": 35, "label": "3.1. Mayor" }, { "Id": 36, "label": "3.2. Menor", "children": [ { "Id": 37, "label": "3.2.1. Natural" }, { "Id": 38, "label": "3.2.2. Armónica" }, { "Id": 39, "label": "3.2.3. Melódica" } ] }, { "Id": 40, "label": "3.3. Modos diatónicos", "children": [ { "Id": 41, "label": "3.3.1. Jónica" }, { "Id": 42, "label": "3.3.2. Dórica" }, { "Id": 43, "label": "3.3.3. Lidia" }, { "Id": 44, "label": "3.3.4. Mixolidia" }, { "Id": 45, "label": "3.3.5. Eólica" }, { "Id": 46, "label": "3.3.6. Locria" } ] }, { "Id": 47, "label": "3.4. Lidia-Mixolidia (1 2 3 #4 5 6 ♭7)" }, { "Id": 48, "label": "3.5. Modos gregorianos", "children": [ { "Id": 49, "label": "3.5.1. Auténticos" }, { "Id": 50, "label": "3.5.2. Plagales" } ] } ] }, { "Id": 17, "label": "4. Octatónicas", "children": [ { "Id": 51, "label": "4.1. Disminuida (Modo II de transposición limitada, Messian)", "children": [ { "Id": 52, "label": "4.1.1. OCT 0,1 (0-1-3-4-6-7-9-10)" }, { "Id": 53, "label": "4.1.2. OCT 1,2 (1-2-4-5-7-8-10-11)" }, { "Id": 54, "label": "4.1.3. OCT 2,3 (2-3-5-6-8-9-11-0)" } ] }, { "Id": 55, "label": "4.2. BeeBop (1 2 3 4 5 6 ♭7 7)" }, { "Id": 56, "label": "4.3. Modo de transposición limitada IV, Messian (0-1-2-5-6-7-8-11)" }, { "Id": 57, "label": "4.4. Modo de transposición limitada VI, Messian (0-2-4-5-6-8-10-11)" } ] }, { "Id": 18, "label": "5. Nonatónicas", "children": [ { "Id": 58, "label": "5.1. Modo de transposición limitada III, Messian (0-2-3-4-6-7-8-10-11)" } ] }, { "Id": 19, "label": "6. Decatónicas", "children": [ { "Id": 59, "label": "6.1. Modo de transposición limitada VII, Messian (0-1-2-3-5-6-7-8-9-11)" } ] } ] }, { "Id": 2, "label": "Acordes", "children": [ { "Id": 60, "label": "1. Tipos", "children": [ { "Id": 62, "label": "1.1. Triadas", "children": [ { "Id": 63, "label": "1.1.1. Mayor" }, { "Id": 64, "label": "1.1.2. Menor" }, { "Id": 65, "label": "1.1.3. Aumentada" }, { "Id": 66, "label": "1.1.4. Disminuida" }, { "Id": 67, "label": "1.1.5. Sus4" }, { "Id": 68, "label": "1.1.6. Sus2" } ] }, { "Id": 69, "label": "1.2. Tetradas", "children": [ { "Id": 70, "label": "1.2.1. Séptima mayor (mayor mayor)" }, { "Id": 71, "label": "1.2.2. Séptima menor (menor menor)" }, { "Id": 72, "label": "1.2.3. Séptima de dominante (mayor menor)" }, { "Id": 73, "label": "1.2.4. Medio disminuida (disminuido menor)" }, { "Id": 74, "label": "1.2.5. Disminuida (disminuido disminuido)" }, { "Id": 75, "label": "1.2.6. Menor-Mayor" }, { "Id": 76, "label": "1.2.7. Aumentada-Mayor" } ] }, { "Id": 77, "label": "1.3. Armonía extendida", "children": [ { "Id": 78, "label": "1.3.1. Acordes de novena" }, { "Id": 79, "label": "1.3.2. Acorde de undécima" }, { "Id": 80, "label": "1.3.3. Acordes decimotercera" }, { "Id": 81, "label": "1.3.4. Acordes con sexta agregada" }, { "Id": 82, "label": "1.3.5. Acordes sin tercera \\\"power chords\\\"" }, { "Id": 83, "label": "1.3.6. Acordes cuartales" }, { "Id": 84, "label": "1.3.7. Poliacordes" } ] } ] }, { "Id": 61, "label": "2. Aplicaciones", "children": [ { "Id": 85, "label": "2.1. Tonales", "children": [ { "Id": 86, "label": "2.1.1. Diatónicos", "children": [ { "Id": 87, "label": "2.1.1.1. Tónica", "children": [ { "Id": 88, "label": "2.1.1.1.1. I" }, { "Id": 89, "label": "2.1.1.1.2. I6" }, { "Id": 90, "label": "2.1.1.1.3. I7" } ] }, { "Id": 91, "label": "2.1.1.2. Subdominante", "children": [ { "Id": 92, "label": "2.1.1.2.1. IV" }, { "Id": 93, "label": "2.1.1.2.2. IV6" }, { "Id": 94, "label": "2.1.1.2.3. IV7" } ] }, { "Id": 95, "label": "2.1.1.3. Dominante", "children": [ { "Id": 96, "label": "2.1.1.3.1. V" }, { "Id": 97, "label": "2.1.1.3.2. V6" }, { "Id": 98, "label": "2.1.1.3.3. V7" }, { "Id": 99, "label": "2.1.1.3.4. V6/5" }, { "Id": 100, "label": "2.1.1.3.5. V4/3" }, { "Id": 101, "label": "2.1.1.3.6. V4/2" }, { "Id": 102, "label": "2.1.1.3.7. Vsus4 9 (\"IV/5\")" }, { "Id": 103, "label": "2.1.1.3.8. V8-7" } ] }, { "Id": 104, "label": "2.1.1.4. Sensible", "children": [ { "Id": 105, "label": "2.1.1.4.1. vii°6" }, { "Id": 106, "label": "2.1.1.4.2. vii°7" }, { "Id": 107, "label": "2.1.1.4.3. vii°6/5" }, { "Id": 108, "label": "2.1.1.4.4. vii°4/3" }, { "Id": 109, "label": "2.1.1.4.5. vii°4/2" } ] }, { "Id": 110, "label": "2.1.1.5. Supertónica", "children": [ { "Id": 111, "label": "2.1.1.5.1. ii" }, { "Id": 112, "label": "2.1.1.5.2. ii6" }, { "Id": 113, "label": "2.1.1.5.3. ii6/5" }, { "Id": 114, "label": "2.1.1.5.4. ii4/3" }, { "Id": 115, "label": "2.1.1.5.5. ii4/2" } ] }, { "Id": 116, "label": "2.1.1.6. Mediante", "children": [ { "Id": 117, "label": "2.1.1.6.1. iii" }, { "Id": 118, "label": "2.1.1.6.2. iii6" }, { "Id": 119, "label": "2.1.1.6.3. iii7" }, { "Id": 120, "label": "2.1.1.6.4. iii6/5" }, { "Id": 121, "label": "2.1.1.6.5. iii4/3" }, { "Id": 122, "label": "2.1.1.6.6. iii4/2" } ] }, { "Id": 123, "label": "2.1.1.7. Submediante", "children": [ { "Id": 124, "label": "2.1.1.7.1. vi" }, { "Id": 125, "label": "2.1.1.7.2. vi6" }, { "Id": 126, "label": "2.1.1.7.3. vi7" }, { "Id": 127, "label": "2.1.1.7.4. vi6/5" }, { "Id": 128, "label": "2.1.1.7.5. vi4/3" }, { "Id": 129, "label": "2.1.1.7.6. vi4/2" } ] }, { "Id": 130, "label": "2.1.1.8. Subtónica", "children": [ { "Id": 131, "label": "2.1.1.8.1. bVII" } ] }, { "Id": 132, "label": "2.1.1.9. Acordes de 6/4", "children": [ { "Id": 133, "label": "2.1.1.9.1. Paso" }, { "Id": 134, "label": "2.1.1.9.2. Auxiliar" }, { "Id": 135, "label": "2.1.1.9.3. Arpegiado" }, { "Id": 136, "label": "2.1.1.9.4. Cadencial" } ] } ] }, { "Id": 137, "label": "2.1.2. Cromáticos", "children": [ { "Id": 138, "label": "2.1.2.1. Dominantes alteradas", "children": [ { "Id": 139, "label": "2.1.2.1.1. V+" }, { "Id": 140, "label": "2.1.2.1.2. Vb5" } ] }, { "Id": 141, "label": "2.1.2.2. Nota común", "children": [ { "Id": 142, "label": "2.1.2.2.1. NC°7" }, { "Id": 143, "label": "2.1.2.2.2. NC6+" }, { "Id": 144, "label": "2.1.2.2.3. NC7" } ] }, { "Id": 145, "label": "2.1.2.3. Acorde de sexta Nap. (bII)" }, { "Id": 146, "label": "2.1.2.4. Acordes de sexta aum", "children": [ { "Id": 147, "label": "2.1.2.4.1. Alem." }, { "Id": 148, "label": "2.1.2.4.2. Fran." }, { "Id": 149, "label": "2.1.2.4.3. Ital." } ] }, { "Id": 150, "label": "2.1.2.5. Mixtura tonal", "children": [ { "Id": 151, "label": "2.1.2.5.1. Simple", "children": [ { "Id": 152, "label": "2.1.2.5.1.1. Mayor", "children": [ { "Id": 153, "label": "2.1.2.5.1.1.1. i" }, { "Id": 154, "label": "2.1.2.5.1.1.2. ii°" }, { "Id": 155, "label": "2.1.2.5.1.1.3. bIII" }, { "Id": 156, "label": "2.1.2.5.1.1.4. iv" }, { "Id": 157, "label": "2.1.2.5.1.1.5. bVI" }, { "Id": 158, "label": "2.1.2.5.1.1.6. bVII" }, { "Id": 160, "label": "2.1.2.5.1.2.1. I" } ] }, { "Id": 159, "label": "2.1.2.5.1.2. Menor" } ] }, { "Id": 161, "label": "2.1.2.5.2. Doble", "children": [ { "Id": 162, "label": "2.1.2.5.2.1. biiii" }, { "Id": 163, "label": "2.1.2.5.2.2. bvi" }, { "Id": 164, "label": "2.1.2.5.2.3. bvii" } ] }, { "Id": 165, "label": "2.1.2.5.3. Secundaria", "children": [ { "Id": 166, "label": "2.1.2.5.3.1. II" }, { "Id": 167, "label": "2.1.2.5.3.2. III" }, { "Id": 168, "label": "2.1.2.5.3.3. VI" }, { "Id": 169, "label": "2.1.2.5.3.4. vii" }, { "Id": 170, "label": "2.1.2.5.3.5. VII" } ] }, { "Id": 171, "label": "2.1.2.5.4. V7(#9)" }, { "Id": 172, "label": "2.1.2.5.5. Sustitución tritonal (subV)" }, { "Id": 173, "label": "2.1.2.5.6. Tonicalización", "children": [ { "Id": 174, "label": "2.1.2.5.6.1. Simple", "children": [ { "Id": 175, "label": "2.1.2.5.6.1.1. Dominantes secundarias", "children": [ { "Id": 176, "label": "2.1.2.5.6.1.1.1. V/V" }, { "Id": 177, "label": "2.1.2.5.6.1.1.2. V/II" }, { "Id": 178, "label": "2.1.2.5.6.1.1.3. V/IV" }, { "Id": 179, "label": "2.1.2.5.6.1.1.4. V/VI" }, { "Id": 180, "label": "2.1.2.5.6.1.1.5. V/III" } ] }, { "Id": 181, "label": "2.1.2.5.6.1.2. Sensibles secundarias", "children": [ { "Id": 182, "label": "2.1.2.5.6.1.2.1. vii°/V" }, { "Id": 183, "label": "2.1.2.5.6.1.2.2. vii°/II" }, { "Id": 184, "label": "2.1.2.5.6.1.2.3. vii°/IV" }, { "Id": 185, "label": "2.1.2.5.6.1.2.4. vii°/VI" }, { "Id": 186, "label": "2.1.2.5.6.1.2.5. vii°/III" } ] } ] }, { "Id": 187, "label": "2.1.2.5.6.2. Extendida" } ] } ] } ] } ] }, { "Id": 188, "label": "2.2. Modales", "children": [ { "Id": 189, "label": "2.2.1. Cadencial Primario", "children": [ { "Id": 190, "label": "2.2.1.1. II-frigio" }, { "Id": 191, "label": "2.2.1.2. VII-eólico" }, { "Id": 192, "label": "2.2.1.3. VII-dórico" }, { "Id": 193, "label": "2.2.1.4. VII-mixolidio" }, { "Id": 194, "label": "2.2.1.5. ii-jónico" }, { "Id": 195, "label": "2.2.1.6. II-lidio" } ] }, { "Id": 196, "label": "2.2.2. Cadencial Secundario", "children": [ { "Id": 197, "label": "2.2.2.1. vii-frigio" }, { "Id": 198, "label": "2.2.2.2. iv-eólico" }, { "Id": 199, "label": "2.2.2.3. ii-eólico" }, { "Id": 200, "label": "2.2.2.4. IV-dórico" }, { "Id": 201, "label": "2.2.2.5. ii-dórico" }, { "Id": 202, "label": "2.2.2.6. v-mixolidio" }, { "Id": 203, "label": "2.2.2.7. ii-mixolidio" }, { "Id": 204, "label": "2.2.2.8. IV-jónico" }, { "Id": 205, "label": "2.2.2.9. vii-lidio" } ] } ] } ] } ] }, { "Id": 3, "label": "Chord scales", "children": [ { "Id": 206, "label": "1. I7 y I6 (jónico)" }, { "Id": 207, "label": "2. ii7 (dórico)" }, { "Id": 208, "label": "3. iii7 (frigio)" }, { "Id": 209, "label": "4. IV7 (lidio)" }, { "Id": 210, "label": "5. V7 (mixolidio)" }, { "Id": 211, "label": "6. vi7 (eólico)" }, { "Id": 212, "label": "7. vii7(b5) (locrio)" } ] }, { "Id": 4, "label": "Funciones armónicas", "children": [ { "Id": 213, "label": "1. Tónica" }, { "Id": 214, "label": "2. Subdominante" }, { "Id": 215, "label": "3. Dominante" } ] }, { "Id": 5, "label": "Cadencias", "children": [ { "Id": 216, "label": "1. Armónicas", "children": [ { "Id": 218, "label": "1.1. Conclusivas", "children": [ { "Id": 219, "label": "1.1.1. Auténtica perfecta" }, { "Id": 220, "label": "1.1.2. Auténtica imperfecta" }, { "Id": 221, "label": "1.1.3. Plagal" }, { "Id": 222, "label": "1.1.4. Landini" } ] }, { "Id": 223, "label": "1.2. Semi-conclusivas", "children": [ { "Id": 224, "label": "1.2.1. Semicadencia auténtica" }, { "Id": 225, "label": "1.2.2. Semicadencia plagal" } ] }, { "Id": 226, "label": "1.3. Desviaciones cadenciales", "children": [ { "Id": 227, "label": "1.3.1. Auténtica deceptiva (rota)" }, { "Id": 228, "label": "1.3.2. Plagal deceptiva" }, { "Id": 229, "label": "1.3.3. Evadida" }, { "Id": 230, "label": "1.3.4. Abandonada" } ] } ] }, { "Id": 217, "label": "2. Melódicas", "children": [ { "Id": 231, "label": "2.1. Conclusivas" }, { "Id": 232, "label": "2.2. Semi-conclusivas" }, { "Id": 233, "label": "2.3. No-conclusivas" } ] } ] }, { "Id": 6, "label": "Texturas", "children": [ { "Id": 234, "label": "1. Monofónica" }, { "Id": 235, "label": "2. Homofónica" }, { "Id": 236, "label": "3. Polifónica" } ] }, { "Id": 7, "label": "Disposiciones", "children": [ { "Id": 237, "label": "1. 4 voces", "children": [ { "Id": 239, "label": "1.1. abierta" }, { "Id": 240, "label": "1.2. cerrada" }, { "Id": 241, "label": "1.3. mixta" } ] }, { "Id": 238, "label": "2. 5 voces", "children": [ { "Id": 242, "label": "2.1. spread voicing" }, { "Id": 243, "label": "2.2. close voicing" } ] } ] }, { "Id": 8, "label": "Notas ornamentales", "children": [ { "Id": 244, "label": "1. Notas de paso" }, { "Id": 245, "label": "2. Bordaduras" }, { "Id": 246, "label": "3. Anticipaciones" }, { "Id": 247, "label": "4. Suspensiones" }, { "Id": 248, "label": "5. Retardaciones" }, { "Id": 249, "label": "6. Pedal" } ] }, { "Id": 9, "label": "Movimiento relativo", "children": [ { "Id": 250, "label": "1. paralelo" }, { "Id": 251, "label": "2. directo" }, { "Id": 252, "label": "3. contrario" }, { "Id": 253, "label": "4. Oblicuo" } ] }, { "Id": 10, "label": "Progresiones armónicas", "children": [ { "Id": 254, "label": "1. Arquetípicas", "children": [ { "Id": 256, "label": "1.1. “Two-five” (ii7-V7-I)" }, { "Id": 257, "label": "1.2. \"Turn around\"(iii-vi-ii-V-I)" }, { "Id": 258, "label": "1.3. Círculo de quintas descendentes" }, { "Id": 259, "label": "1.4. T-S-D-T (progresión auténtica)" }, { "Id": 260, "label": "1.5. T-D-S-T (progresión plagal)" }, { "Id": 261, "label": "1.6. “Double plagal” (I-bVII-IV-I)" }, { "Id": 262, "label": "1.7. “Best seller” (I-V-vi-IV)" }, { "Id": 263, "label": "1.8. i-bVII-bVI-bVII-i" }, { "Id": 264, "label": "1.9. bVI-bVII-i" }, { "Id": 265, "label": "1.10. 12-bar blues" }, { "Id": 266, "label": "1.11. Circuito sintáctico interpolado (CSI)" }, { "Id": 267, "label": "1.12. Ciclos octatónicos" }, { "Id": 268, "label": "1.13. Ciclos hexatónicos" } ] }, { "Id": 255, "label": "2. Secuenciales", "children": [ { "Id": 269, "label": "2.1. De quintas", "children": [ { "Id": 272, "label": "2.1.1. Ascendentes" }, { "Id": 273, "label": "2.1.2. Descendentes" } ] }, { "Id": 270, "label": "2.2. De segundas", "children": [ { "Id": 274, "label": "2.2.1. Ascendentes" }, { "Id": 275, "label": "2.2.2. Descendentes" } ] }, { "Id": 271, "label": "2.3. De terceras", "children": [ { "Id": 276, "label": "2.3.1. Ascendentes" }, { "Id": 277, "label": "2.3.2. Descendentes" } ] } ] } ] }, { "Id": 11, "label": "Modulación", "children": [ { "Id": 278, "label": "1. Diatónica (acorde común)" }, { "Id": 279, "label": "2. Cromática" }, { "Id": 280, "label": "3. Enarmónica" }, { "Id": 281, "label": "4. Directa" }, { "Id": 282, "label": "5. Secuencial" } ] }, { "Id": 12, "label": "Transformaciones Neo-riemannianas", "children": [ { "Id": 283, "label": "1. Simples", "children": [ { "Id": 284, "label": "1.1. Primarias", "children": [ { "Id": 285, "label": "1.1.1. P" }, { "Id": 286, "label": "1.1.2. L" }, { "Id": 287, "label": "1.1.3. R" } ] }, { "Id": 288, "label": "1.2. Secundarias", "children": [ { "Id": 289, "label": "1.2.1. S" }, { "Id": 290, "label": "1.2.2. N" }, { "Id": 291, "label": "1.2.3. R1" }, { "Id": 292, "label": "1.2.4. H" } ] } ] }, { "Id": 293, "label": "2. Compuestas" } ] }, { "Id": 13, "label": "Conducción de voces tradicional", "children": [ { "Id": 294, "label": "1. Enlaces sin movimiento paralelo entre consonancias perfectas (i.e., 5tas y 8vas paralelas y antiparalelas)" }, { "Id": 295, "label": "2. Enlaces sin movimiento directo hacia consonancias perfectas (i.e., 5tas y 8vas ocultas)" }, { "Id": 296, "label": "3. Enlaces sin movimiento paralelo entre 5tas de distintas calidad (i.e. 5tas desiguales)" }, { "Id": 297, "label": "4. Enlaces con tratamiento regular e irregular de la sensible" }, { "Id": 298, "label": "5. Tratamiento regular de la disonancia" }, { "Id": 299, "label": "6. Resolución irregular de la disonancia (diferida e indirecta)" }, { "Id": 300, "label": "7. Enlaces con y sin cruzamiento de voces" }, { "Id": 301, "label": "8. Conducción armónica paralela (planning)" } ] } ];
    this.ejemploCategoria = [
      {
        "id": 1,
        "ejemploId": 1,
        "categoriaId": 225
      },
      {
        "id": 2,
        "ejemploId": 2,
        "categoriaId": 226
      },
      {
        "id": 3,
        "ejemploId": 3,
        "categoriaId": 20
      },
      {
        "id": 4,
        "ejemploId": 4,
        "categoriaId": 21
      },
      {
        "id": 5,
        "ejemploId": 5,
        "categoriaId": 22
      }
    ];
    this.ejemplos = [
    {
      "id": 1,
      "nombre": "Spinetta Jade",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/SpinettaJade.mp3",
      "imagen": "https://raw.githubusercontent.com/Faez777/base-musical/refs/heads/main/assets/SpinettaJade.jpeg",
      "partitura": "https://github.com/Faez777/base-musical/raw/main/assets/SpinettaJadeAlmaDeDiamante.pdf"
    },
    {
      "id": 2,
      "nombre": "Caetano Veloso",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/CaetanoVeloso.mp3",
      "imagen": "https://github.com/Faez777/base-musical/raw/main/assets/CaetanoVeloso.jpeg",
      "partitura": "https://github.com/Faez777/base-musical/raw/main/assets/CaetanoVelosoTremDasCores.pdf"
    },
    {
      "id": 3,
      "nombre": "Ejemplo 1",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/brainwork-254155.mp3",
      "imagen": "https://github.com/Faez777/base-musical/raw/main/assets/traducir-notas-partituras-piano.png.jpg",
      "partitura": "https://github.com/Faez777/base-musical/raw/main/assets/Práctica encuadres.pdf"
    },
    {
      "id": 4,
      "nombre": "Ejemplo 2",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/intro-rampb-instrumental-loop-244659.mp3",
      "imagen": "https://github.com/Faez777/base-musical/raw/main/assets/images.png",
      "partitura": "https://github.com/Faez777/base-musical/raw/main/assets/Práctica encuadres.pdf"
    },
    {
      "id": 5,
      "nombre": "Ejemplo 3",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/magiksolo-beginning-investigation-232340.mp3",
      "imagen": "https://github.com/Faez777/base-musical/raw/main/assets/traducir-notas-partituras-piano.png.jpg",
      "partitura": "https://github.com/Faez777/base-musical/raw/main/assets/Práctica encuadres.pdf"
    },
  ];

    this.musicalCategories = [{"id": 1,"name": "Escalas","parentId": null},{"id": 2,"name": "Acordes","parentId": null},{"id": 3,"name": "Chord scales","parentId": null},{"id": 4,"name": "Funciones armónicas","parentId": null},{"id": 5,"name": "Cadencias","parentId": null},{"id": 6,"name": "Texturas","parentId": null},{"id": 7,"name": "Disposiciones","parentId": null},{"id": 8,"name": "Notas ornamentales","parentId": null},{"id": 9,"name": "Movimiento relativo","parentId": null},{"id": 10,"name": "Progresiones armónicas","parentId": null},{"id": 11,"name": "Modulación","parentId": null},{"id": 12,"name": "Transformaciones Neo-riemannianas","parentId": null},{"id": 13,"name": "Conducción de voces tradicional","parentId": null},{"id": 14,"name": "1. Pentatónicas","parentId": 1},{"id": 15,"name": "2. Hexatónicas","parentId": 1},{"id": 16,"name": "3. Heptatónicas","parentId": 1},{"id": 17,"name": "4. Octatónicas","parentId": 1},{"id": 18,"name": "5. Nonatónicas","parentId": 1},{"id": 19,"name": "6. Decatónicas","parentId": 1},{"id": 20,"name": "1.1. Modo I (mayor): 1 2 3 5 6","parentId": 14},{"id": 21,"name": "1.2. Modo II: 1 2 4 5 ♭7","parentId": 14},{"id": 22,"name": "1.3. Modo III: 1 ♭3 4 ♭6 ♭7","parentId": 14},{"id": 23,"name": "1.4. Modo IV: 1 2 4 5 6","parentId": 14},{"id": 24,"name": "1.5. Modo V (menor): 1 ♭3 4 5 ♭7","parentId": 14},{"id": 25,"name": "2.1. Tonos enteros (Modo I de transposición limitada, Messian)","parentId": 15},{"id": 26,"name": "2.1.1. TE<sub>0</sub> (0-2-4-6-8-10)","parentId": 25},{"id": 27,"name": "2.1.2. TE<sub>1</sub> (1-3-5-7-9-11)","parentId": 25},{"id": 28,"name": "2.2. Escala de blues (1 b3 4 #4/b5 5 b7)","parentId": 15},{"id": 29,"name": "2.3. Aumentada","parentId": 15},{"id": 30,"name": "2.3.1. HEX 0,1 (0-1-4-5-8-9)","parentId": 29},{"id": 31,"name": "2.3.2. HEX 1,2 (1-2-5-6-9-10)","parentId": 29},{"id": 32,"name": "2.3.3. HEX 2,3 (2-3-6-7-10-11)","parentId": 29},{"id": 33,"name": "2.3.4. HEX 3,4 (3-4-7-8-11-0)","parentId": 29},{"id": 34,"name": "2.4. Modo de transposición limitada V, Messian (0-1-5-6-7-11)","parentId": 15},{"id": 35,"name": "3.1. Mayor","parentId": 16},{"id": 36,"name": "3.2. Menor","parentId": 16},{"id": 37,"name": "3.2.1. Natural","parentId": 36},{"id": 38,"name": "3.2.2. Armónica","parentId": 36},{"id": 39,"name": "3.2.3. Melódica","parentId": 36},{"id": 40,"name": "3.3. Modos diatónicos","parentId": 16},{"id": 41,"name": "3.3.1. Jónica","parentId": 40},{"id": 42,"name": "3.3.2. Dórica","parentId": 40},{"id": 43,"name": "3.3.3. Lidia","parentId": 40},{"id": 44,"name": "3.3.4. Mixolidia","parentId": 40},{"id": 45,"name": "3.3.5. Eólica","parentId": 40},{"id": 46,"name": "3.3.6. Locria","parentId": 40},{"id": 47,"name": "3.4. Lidia-Mixolidia (1 2 3 #4 5 6 ♭7)","parentId": 16},{"id": 48,"name": "3.5. Modos gregorianos","parentId": 16},{"id": 49,"name": "3.5.1. Auténticos","parentId": 48},{"id": 50,"name": "3.5.2. Plagales","parentId": 48},{"id": 51,"name": "4.1. Disminuida (Modo II de transposición limitada, Messian)","parentId": 17},{"id": 52,"name": "4.1.1. OCT 0,1 (0-1-3-4-6-7-9-10)","parentId": 51},{"id": 53,"name": "4.1.2. OCT 1,2 (1-2-4-5-7-8-10-11)","parentId": 51},{"id": 54,"name": "4.1.3. OCT 2,3 (2-3-5-6-8-9-11-0)","parentId": 51},{"id": 55,"name": "4.2. BeeBop (1 2 3 4 5 6 ♭7 7)","parentId": 17},{"id": 56,"name": "4.3. Modo de transposición limitada IV, Messian (0-1-2-5-6-7-8-11)","parentId": 17},{"id": 57,"name": "4.4. Modo de transposición limitada VI, Messian (0-2-4-5-6-8-10-11)","parentId": 17},{"id": 58,"name": "5.1. Modo de transposición limitada III, Messian (0-2-3-4-6-7-8-10-11)","parentId": 18},{"id": 59,"name": "6.1. Modo de transposición limitada VII, Messian (0-1-2-3-5-6-7-8-9-11)","parentId": 19},{"id": 60,"name": "1. Tipos","parentId": 2},{"id": 61,"name": "2. Aplicaciones","parentId": 2},{"id": 62,"name": "1.1. Triadas","parentId": 60},{"id": 63,"name": "1.1.1. Mayor","parentId": 62},{"id": 64,"name": "1.1.2. Menor","parentId": 62},{"id": 65,"name": "1.1.3. Aumentada","parentId": 62},{"id": 66,"name": "1.1.4. Disminuida","parentId": 62},{"id": 67,"name": "1.1.5. Sus4","parentId": 62},{"id": 68,"name": "1.1.6. Sus2","parentId": 62},{"id": 69,"name": "1.2. Tetradas","parentId": 60},{"id": 70,"name": "1.2.1. Séptima mayor (mayor mayor)","parentId": 69},{"id": 71,"name": "1.2.2. Séptima menor (menor menor)","parentId": 69},{"id": 72,"name": "1.2.3. Séptima de dominante (mayor menor)","parentId": 69},{"id": 73,"name": "1.2.4. Medio disminuida (disminuido menor)","parentId": 69},{"id": 74,"name": "1.2.5. Disminuida (disminuido disminuido)","parentId": 69},{"id": 75,"name": "1.2.6. Menor-Mayor","parentId": 69},{"id": 76,"name": "1.2.7. Aumentada-Mayor","parentId": 69},{"id": 77,"name": "1.3. Armonía extendida","parentId": 60},{"id": 78,"name": "1.3.1. Acordes de novena","parentId": 77},{"id": 79,"name": "1.3.2. Acorde de undécima","parentId": 77},{"id": 80,"name": "1.3.3. Acordes decimotercera","parentId": 77},{"id": 81,"name": "1.3.4. Acordes con sexta agregada","parentId": 77},{"id": 82,"name": "1.3.5. Acordes sin tercera \\\"power chords\\\"","parentId": 77},{"id": 83,"name": "1.3.6. Acordes cuartales","parentId": 77},{"id": 84,"name": "1.3.7. Poliacordes","parentId": 77},{"id": 85,"name": "2.1. Tonales","parentId": 61},{"id": 86,"name": "2.1.1. Diatónicos","parentId": 85},{"id": 87,"name": "2.1.1.1. Tónica","parentId": 86},{"id": 88,"name": "2.1.1.1.1. I","parentId": 87},{"id": 89,"name": "2.1.1.1.2. I6","parentId": 87},{"id": 90,"name": "2.1.1.1.3. I7","parentId": 87},{"id": 91,"name": "2.1.1.2. Subdominante","parentId": 86},{"id": 92,"name": "2.1.1.2.1. IV","parentId": 91},{"id": 93,"name": "2.1.1.2.2. IV6","parentId": 91},{"id": 94,"name": "2.1.1.2.3. IV7","parentId": 91},{"id": 95,"name": "2.1.1.3. Dominante","parentId": 86},{"id": 96,"name": "2.1.1.3.1. V","parentId": 95},{"id": 97,"name": "2.1.1.3.2. V6","parentId": 95},{"id": 98,"name": "2.1.1.3.3. V7","parentId": 95},{"id": 99,"name": "2.1.1.3.4. V6/5","parentId": 95},{"id": 100,"name": "2.1.1.3.5. V4/3","parentId": 95},{"id": 101,"name": "2.1.1.3.6. V4/2","parentId": 95},{"id": 102,"name": "2.1.1.3.7. Vsus4 9 (\"IV/5\")","parentId": 95},{"id": 103,"name": "2.1.1.3.8. V8-7","parentId": 95},{"id": 104,"name": "2.1.1.4. Sensible","parentId": 86},{"id": 105,"name": "2.1.1.4.1. vii°6","parentId": 104},{"id": 106,"name": "2.1.1.4.2. vii°7","parentId": 104},{"id": 107,"name": "2.1.1.4.3. vii°6/5","parentId": 104},{"id": 108,"name": "2.1.1.4.4. vii°4/3","parentId": 104},{"id": 109,"name": "2.1.1.4.5. vii°4/2","parentId": 104},{"id": 110,"name": "2.1.1.5. Supertónica","parentId": 86},{"id": 111,"name": "2.1.1.5.1. ii","parentId": 110},{"id": 112,"name": "2.1.1.5.2. ii6","parentId": 110},{"id": 113,"name": "2.1.1.5.3. ii6/5","parentId": 110},{"id": 114,"name": "2.1.1.5.4. ii4/3","parentId": 110},{"id": 115,"name": "2.1.1.5.5. ii4/2","parentId": 110},{"id": 116,"name": "2.1.1.6. Mediante","parentId": 86},{"id": 117,"name": "2.1.1.6.1. iii","parentId": 116},{"id": 118,"name": "2.1.1.6.2. iii6","parentId": 116},{"id": 119,"name": "2.1.1.6.3. iii7","parentId": 116},{"id": 120,"name": "2.1.1.6.4. iii6/5","parentId": 116},{"id": 121,"name": "2.1.1.6.5. iii4/3","parentId": 116},{"id": 122,"name": "2.1.1.6.6. iii4/2","parentId": 116},{"id": 123,"name": "2.1.1.7. Submediante","parentId": 86},{"id": 124,"name": "2.1.1.7.1. vi","parentId": 123},{"id": 125,"name": "2.1.1.7.2. vi6","parentId": 123},{"id": 126,"name": "2.1.1.7.3. vi7","parentId": 123},{"id": 127,"name": "2.1.1.7.4. vi6/5","parentId": 123},{"id": 128,"name": "2.1.1.7.5. vi4/3","parentId": 123},{"id": 129,"name": "2.1.1.7.6. vi4/2","parentId": 123},{"id": 130,"name": "2.1.1.8. Subtónica","parentId": 86},{"id": 131,"name": "2.1.1.8.1. bVII","parentId": 130},{"id": 132,"name": "2.1.1.9. Acordes de 6/4","parentId": 86},{"id": 133,"name": "2.1.1.9.1. Paso","parentId": 132},{"id": 134,"name": "2.1.1.9.2. Auxiliar","parentId": 132},{"id": 135,"name": "2.1.1.9.3. Arpegiado","parentId": 132},{"id": 136,"name": "2.1.1.9.4. Cadencial","parentId": 132},{"id": 137,"name": "2.1.2. Cromáticos","parentId": 85},{"id": 138,"name": "2.1.2.1. Dominantes alteradas","parentId": 137},{"id": 139,"name": "2.1.2.1.1. V+","parentId": 138},{"id": 140,"name": "2.1.2.1.2. Vb5","parentId": 138},{"id": 141,"name": "2.1.2.2. Nota común","parentId": 137},{"id": 142,"name": "2.1.2.2.1. NC°7","parentId": 141},{"id": 143,"name": "2.1.2.2.2. NC6+","parentId": 141},{"id": 144,"name": "2.1.2.2.3. NC7","parentId": 141},{"id": 145,"name": "2.1.2.3. Acorde de sexta Nap. (bII)","parentId": 137},{"id": 146,"name": "2.1.2.4. Acordes de sexta aum","parentId": 137},{"id": 147,"name": "2.1.2.4.1. Alem.","parentId": 146},{"id": 148,"name": "2.1.2.4.2. Fran.","parentId": 146},{"id": 149,"name": "2.1.2.4.3. Ital.","parentId": 146},{"id": 150,"name": "2.1.2.5. Mixtura tonal","parentId": 137},{"id": 151,"name": "2.1.2.5.1. Simple","parentId": 150},{"id": 152,"name": "2.1.2.5.1.1. Mayor","parentId": 151},{"id": 153,"name": "2.1.2.5.1.1.1. i","parentId": 152},{"id": 154,"name": "2.1.2.5.1.1.2. ii°","parentId": 152},{"id": 155,"name": "2.1.2.5.1.1.3. bIII","parentId": 152},{"id": 156,"name": "2.1.2.5.1.1.4. iv","parentId": 152},{"id": 157,"name": "2.1.2.5.1.1.5. bVI","parentId": 152},{"id": 158,"name": "2.1.2.5.1.1.6. bVII","parentId": 152},{"id": 159,"name": "2.1.2.5.1.2. Menor","parentId": 151},{"id": 160,"name": "2.1.2.5.1.2.1. I","parentId": 152},{"id": 161,"name": "2.1.2.5.2. Doble","parentId": 150},{"id": 162,"name": "2.1.2.5.2.1. biiii","parentId": 161},{"id": 163,"name": "2.1.2.5.2.2. bvi","parentId": 161},{"id": 164,"name": "2.1.2.5.2.3. bvii","parentId": 161},{"id": 165,"name": "2.1.2.5.3. Secundaria","parentId": 150},{"id": 166,"name": "2.1.2.5.3.1. II","parentId": 165},{"id": 167,"name": "2.1.2.5.3.2. III","parentId": 165},{"id": 168,"name": "2.1.2.5.3.3. VI","parentId": 165},{"id": 169,"name": "2.1.2.5.3.4. vii","parentId": 165},{"id": 170,"name": "2.1.2.5.3.5. VII","parentId": 165},{"id": 171,"name": "2.1.2.5.4. V7(#9)","parentId": 150},{"id": 172,"name": "2.1.2.5.5. Sustitución tritonal (subV)","parentId": 150},{"id": 173,"name": "2.1.2.5.6. Tonicalización","parentId": 150},{"id": 174,"name": "2.1.2.5.6.1. Simple","parentId": 173},{"id": 175,"name": "2.1.2.5.6.1.1. Dominantes secundarias","parentId": 174},{"id": 176,"name": "2.1.2.5.6.1.1.1. V/V","parentId": 175},{"id": 177,"name": "2.1.2.5.6.1.1.2. V/II","parentId": 175},{"id": 178,"name": "2.1.2.5.6.1.1.3. V/IV","parentId": 175},{"id": 179,"name": "2.1.2.5.6.1.1.4. V/VI","parentId": 175},{"id": 180,"name": "2.1.2.5.6.1.1.5. V/III","parentId": 175},{"id": 181,"name": "2.1.2.5.6.1.2. Sensibles secundarias","parentId": 174},{"id": 182,"name": "2.1.2.5.6.1.2.1. vii°/V","parentId": 181},{"id": 183,"name": "2.1.2.5.6.1.2.2. vii°/II","parentId": 181},{"id": 184,"name": "2.1.2.5.6.1.2.3. vii°/IV","parentId": 181},{"id": 185,"name": "2.1.2.5.6.1.2.4. vii°/VI","parentId": 181},{"id": 186,"name": "2.1.2.5.6.1.2.5. vii°/III","parentId": 181},{"id": 187,"name": "2.1.2.5.6.2. Extendida","parentId": 173},{"id": 188,"name": "2.2. Modales","parentId": 61},{"id": 189,"name": "2.2.1. Cadencial Primario","parentId": 188},{"id": 190,"name": "2.2.1.1. II-frigio","parentId": 189},{"id": 191,"name": "2.2.1.2. VII-eólico","parentId": 189},{"id": 192,"name": "2.2.1.3. VII-dórico","parentId": 189},{"id": 193,"name": "2.2.1.4. VII-mixolidio","parentId": 189},{"id": 194,"name": "2.2.1.5. ii-jónico","parentId": 189},{"id": 195,"name": "2.2.1.6. II-lidio","parentId": 189},{"id": 196,"name": "2.2.2. Cadencial Secundario","parentId": 188},{"id": 197,"name": "2.2.2.1. vii-frigio","parentId": 196},{"id": 198,"name": "2.2.2.2. iv-eólico","parentId": 196},{"id": 199,"name": "2.2.2.3. ii-eólico","parentId": 196},{"id": 200,"name": "2.2.2.4. IV-dórico","parentId": 196},{"id": 201,"name": "2.2.2.5. ii-dórico","parentId": 196},{"id": 202,"name": "2.2.2.6. v-mixolidio","parentId": 196},{"id": 203,"name": "2.2.2.7. ii-mixolidio","parentId": 196},{"id": 204,"name": "2.2.2.8. IV-jónico","parentId": 196},{"id": 205,"name": "2.2.2.9. vii-lidio","parentId": 196},{"id": 206,"name": "1. I7 y I6 (jónico)","parentId": 3},{"id": 207,"name": "2. ii7 (dórico)","parentId": 3},{"id": 208,"name": "3. iii7 (frigio)","parentId": 3},{"id": 209,"name": "4. IV7 (lidio)","parentId": 3},{"id": 210,"name": "5. V7 (mixolidio)","parentId": 3},{"id": 211,"name": "6. vi7 (eólico)","parentId": 3},{"id": 212,"name": "7. vii7(b5) (locrio)","parentId": 3},{"id": 213,"name": "1. Tónica","parentId": 4},{"id": 214,"name": "2. Subdominante","parentId": 4},{"id": 215,"name": "3. Dominante","parentId": 4},{"id": 216,"name": "1. Armónicas","parentId": 5},{"id": 217,"name": "2. Melódicas","parentId": 5},{"id": 218,"name": "1.1. Conclusivas","parentId": 216},{"id": 219,"name": "1.1.1. Auténtica perfecta","parentId": 218},{"id": 220,"name": "1.1.2. Auténtica imperfecta","parentId": 218},{"id": 221,"name": "1.1.3. Plagal","parentId": 218},{"id": 222,"name": "1.1.4. Landini","parentId": 218},{"id": 223,"name": "1.2. Semi-conclusivas","parentId": 216},{"id": 224,"name": "1.2.1. Semicadencia auténtica","parentId": 223},{"id": 225,"name": "1.2.2. Semicadencia plagal","parentId": 223},{"id": 226,"name": "1.3. Desviaciones cadenciales","parentId": 216},{"id": 227,"name": "1.3.1. Auténtica deceptiva (rota)","parentId": 226},{"id": 228,"name": "1.3.2. Plagal deceptiva","parentId": 226},{"id": 229,"name": "1.3.3. Evadida","parentId": 226},{"id": 230,"name": "1.3.4. Abandonada","parentId": 226},{"id": 231,"name": "2.1. Conclusivas","parentId": 217},{"id": 232,"name": "2.2. Semi-conclusivas","parentId": 217},{"id": 233,"name": "2.3. No-conclusivas","parentId": 217},{"id": 234,"name": "1. Monofónica","parentId": 6},{"id": 235,"name": "2. Homofónica","parentId": 6},{"id": 236,"name": "3. Polifónica","parentId": 6},{"id": 237,"name": "1. 4 voces","parentId": 7},{"id": 238,"name": "2. 5 voces","parentId": 7},{"id": 239,"name": "1.1. abierta","parentId": 237},{"id": 240,"name": "1.2. cerrada","parentId": 237},{"id": 241,"name": "1.3. mixta","parentId": 237},{"id": 242,"name": "2.1. spread voicing","parentId": 238},{"id": 243,"name": "2.2. close voicing","parentId": 238},{"id": 244,"name": "1. Notas de paso","parentId": 8},{"id": 245,"name": "2. Bordaduras","parentId": 8},{"id": 246,"name": "3. Anticipaciones","parentId": 8},{"id": 247,"name": "4. Suspensiones","parentId": 8},{"id": 248,"name": "5. Retardaciones","parentId": 8},{"id": 249,"name": "6. Pedal","parentId": 8},{"id": 250,"name": "1. paralelo","parentId": 9},{"id": 251,"name": "2. directo","parentId": 9},{"id": 252,"name": "3. contrario","parentId": 9},{"id": 253,"name": "4. Oblicuo","parentId": 9},{"id": 254,"name": "1. Arquetípicas","parentId": 10},{"id": 255,"name": "2. Secuenciales","parentId": 10},{"id": 256,"name": "1.1. “Two-five” (ii7-V7-I)","parentId": 254},{"id": 257,"name": "1.2. \"Turn around\"(iii-vi-ii-V-I)","parentId": 254},{"id": 258,"name": "1.3. Círculo de quintas descendentes","parentId": 254},{"id": 259,"name": "1.4. T-S-D-T (progresión auténtica)","parentId": 254},{"id": 260,"name": "1.5. T-D-S-T (progresión plagal)","parentId": 254},{"id": 261,"name": "1.6. “Double plagal” (I-bVII-IV-I)","parentId": 254},{"id": 262,"name": "1.7. “Best seller” (I-V-vi-IV)","parentId": 254},{"id": 263,"name": "1.8. i-bVII-bVI-bVII-i","parentId": 254},{"id": 264,"name": "1.9. bVI-bVII-i","parentId": 254},{"id": 265,"name": "1.10. 12-bar blues","parentId": 254},{"id": 266,"name": "1.11. Circuito sintáctico interpolado (CSI)","parentId": 254},{"id": 267,"name": "1.12. Ciclos octatónicos","parentId": 254},{"id": 268,"name": "1.13. Ciclos hexatónicos","parentId": 254},{"id": 269,"name": "2.1. De quintas","parentId": 255},{"id": 270,"name": "2.2. De segundas","parentId": 255},{"id": 271,"name": "2.3. De terceras","parentId": 255},{"id": 272,"name": "2.1.1. Ascendentes","parentId": 269},{"id": 273,"name": "2.1.2. Descendentes","parentId": 269},{"id": 274,"name": "2.2.1. Ascendentes","parentId": 270},{"id": 275,"name": "2.2.2. Descendentes","parentId": 270},{"id": 276,"name": "2.3.1. Ascendentes","parentId": 271},{"id": 277,"name": "2.3.2. Descendentes","parentId": 271},{"id": 278,"name": "1. Diatónica (acorde común)","parentId": 11},{"id": 279,"name": "2. Cromática","parentId": 11},{"id": 280,"name": "3. Enarmónica","parentId": 11},{"id": 281,"name": "4. Directa","parentId": 11},{"id": 282,"name": "5. Secuencial","parentId": 11},{"id": 283,"name": "1. Simples","parentId": 12},{"id": 284,"name": "1.1. Primarias","parentId": 283},{"id": 285,"name": "1.1.1. P","parentId": 284},{"id": 286,"name": "1.1.2. L","parentId": 284},{"id": 287,"name": "1.1.3. R","parentId": 284},{"id": 288,"name": "1.2. Secundarias","parentId": 283},{"id": 289,"name": "1.2.1. S","parentId": 288},{"id": 290,"name": "1.2.2. N","parentId": 288},{"id": 291,"name": "1.2.3. R1","parentId": 288},{"id": 292,"name": "1.2.4. H","parentId": 288},{"id": 293,"name": "2. Compuestas","parentId": 12},{"id": 294,"name": "1. Enlaces sin movimiento paralelo entre consonancias perfectas (i.e., 5tas y 8vas paralelas y antiparalelas)","parentId": 13},{"id": 295,"name": "2. Enlaces sin movimiento directo hacia consonancias perfectas (i.e., 5tas y 8vas ocultas)","parentId": 13},{"id": 296,"name": "3. Enlaces sin movimiento paralelo entre 5tas de distintas calidad (i.e. 5tas desiguales)","parentId": 13},{"id": 297,"name": "4. Enlaces con tratamiento regular e irregular de la sensible","parentId": 13},{"id": 298,"name": "5. Tratamiento regular de la disonancia","parentId": 13},{"id": 299,"name": "6. Resolución irregular de la disonancia (diferida e indirecta)","parentId": 13},{"id": 300,"name": "7. Enlaces con y sin cruzamiento de voces","parentId": 13},{"id": 301,"name": "8. Conducción armónica paralela (planning)","parentId": 13}];
    try {
      this.fetchExamples();
      console.log("Ejemplos: ", this.examples);
    } catch (error) {
      console.error("Error al obtener las categorías musicales: ", error);
    }
  },
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Raleway:wght@400;600&family=Lora:wght@400;700&display=swap');
/* General */
.music-filter {
  font-family: 'Poppins', sans-serif;
  background: #f9fafb; /* Fondo neutro */
  color: #4a4a4a;
}

/* Header */
header {
  background: #00509e; /* Azul UCR */
  color: white;
  padding: 15px 20px;
}

header h1 {
  font-family: 'Poppins', sans-serif;
  font-weight: 600;
  font-size: 1.8rem;
  color: #ffffff;
}
header h7 {
  font-family: 'Poppins', sans-serif;
}
header img {
  width: 120px;
  height: 120px;
  border-radius: 8px;
  transition: transform 0.3s ease;
}

header img:hover {
  transform: scale(1.05);
}

/* Títulos */
h3, h5 {
  font-family: 'Poppins', sans-serif;
  font-weight: 600;
  color: #00509e;
}

/* Botones */
.btn {
  font-family: 'Poppins', sans-serif;
  font-weight: 500;
  border-radius: 8px;
  padding: 10px 15px;
  transition: transform 0.2s ease, background-color 0.3s ease;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

.btn:hover {
  transform: translateY(-3px);
}

.btn-info {
  background-color: #007bb5;
  color: white;
}

.btn-info:hover {
  background-color: #00509e;
}

.btn-success {
  background-color: #28a745;
  color: white;
}

.btn-success:hover {
  background-color: #218838;
}

/* Listas */
.list-group-item {
  background-color: #ffffff;
  border: 1px solid #dcdcdc;
  border-radius: 6px;
  transition: box-shadow 0.2s ease;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
}
.example-title-container {
  flex: 1;
  text-align: left;
}
.example-title {
  font-size: 1.25rem; /* Aumenta el tamaño de la fuente */
  line-height: 1.5;
}
.list-group-item:hover {
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}


.dynamic-tree {
  background-color: #ffffff; /* Fondo del contenedor */
  border: 1px solid #e5e5e5; /* Borde */
  border-radius: 6px; /* Bordes redondeados */
  padding: 10px; /* Espaciado interno */
  height: 500px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* Sombra */
}

.tree-select {
  max-width: 425px;
  width: 100%;
  overflow: scroll; /* Activa los dos scrolls (vertical y horizontal) */
}

.el-tree {
  max-height: 425px;
  overflow: auto; /* Habilita tanto el scroll horizontal como vertical si el contenido excede las dimensiones */
}

/* Modal */
.modal-content {
  background: white;
  border-radius: 12px;
  padding: 20px;
}

.modal-header {
  background-color: #00509e;
  color: white;
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
}

.modal-footer {
  display: flex;
  justify-content: space-between;
}

/* Imagen dentro del modal */
.partitura-image {
  width: 100%;
  max-width: 600px;
  height: auto;
  border-radius: 8px;
  margin: auto;
  display: block;
}
/* General adjustments for mobile */
@media (max-width: 768px) {
  .music-filter {
    padding: 10px;
  }

  header {
    flex-direction: column;
    text-align: center;
    gap: 10px;
  }

  header h1 {
    font-size: 1.4rem;
  }

  header img {
    width: 80px;
    height: 80px;
  }

  /* Filtros y ejemplos */
  .row {
    flex-direction: column;
  }

  .col-md-3,
  .col-md-9 {
    width: 100%;
    padding: 10px 0;
  }

  .dynamic-tree {
    height: auto;
    max-height: 400px; /* Ajuste de altura para móviles */
  }
  .el-tree {
    max-height: 325px;
    overflow: auto; /* Habilita tanto el scroll horizontal como vertical si el contenido excede las dimensiones */
  }

  .tree-select {
    max-width: 100%;
  }

  /* Botones */
  .button-group button,
  .button-group a {
    padding: 8px 10px;
    font-size: 0.9rem;
  }

  /* Ejemplos */
  .list-group-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }

  .example-details {
    width: 100%;
  }

  audio {
    width: 100%;
  }

  /* Footer */
  footer {
    font-size: 0.8rem;
  }
}

</style>