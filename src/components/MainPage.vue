<template>
  <div class="music-filter">
    <h2>Filtrar Ejemplos Musicales</h2>
    <div class="filter-container">
      <div class="dynamic-tree">
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

      <div v-if="selectedItems.length > 0" class="selected-items">
        <h3>Elementos seleccionados:</h3>
        <ul>
          <li v-for="item in selectedItems" :key="item">
            {{ item }}
            <span class="remove-item" @click="removeSelectedItem(item)">✖</span>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <div v-if="examples.length > 0">
    <h3>Ejemplos Encontrados:</h3>
    <ul class="list-group">
      <li
        v-for="example in examples"
        :key="example.id"
        class="list-group-item d-flex justify-content-between align-items-start"
      >
        <!-- Contenedor para el nombre y la descripción -->
        <div class="d-flex flex-column">
          <strong>{{ example.nombre }}</strong>
          <p class="mb-1 text-muted">{{ example.descripcion }}</p>
        </div>

        <!-- Contenedor para los botones y el reproductor de audio -->
        <div class="d-flex align-items-center gap-2">
          <button
            v-if="getFileType(example.descripcion) === 'image'"
            class="btn btn-info"
            @click="openModal(example.descripcion)"
          >
            Ver Partitura
          </button>
          <a :href="example.descripcion" class="btn btn-success" download>Descargar partitura</a>
          <audio controls class="ms-3" :src="example.rutaArchivo">
            Your browser does not support the audio element.
          </audio>
        </div>
      </li>
    </ul>
  </div>

  <div v-else>
    <h3>No hay ejemplos disponibles.</h3>
  </div>
  <div class="modal fade" id="partituraModal" tabindex="-1" aria-labelledby="partituraModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="partituraModalLabel">Partitura</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div v-if="fileType === 'image'">
            <img :src="fileUrl" class="img-fluid" alt="Partitura">
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
    openModal(descripcion) {
        // Determinar el tipo de archivo (imagen o PDF)
        this.fileUrl = descripcion;
        this.fileType = this.getFileType(descripcion);

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
    this.musicalOptions2 = [ { "Id": 1, "label": "Escalas", "children": [ { "Id": 14, "label": "1. Pentatónicas", "children": [ { "Id": 20, "label": "1.1. Modo I (mayor): 1 2 3 5 6" }, { "Id": 21, "label": "1.2. Modo II: 2 3 5 6 1" }, { "Id": 22, "label": "1.3. Modo III: 3 5 6 1 2" }, { "Id": 23, "label": "1.4. Modo IV: 5 6 1 2 3" }, { "Id": 24, "label": "1.5. Modo V (menor): 6 1 2 3 5" } ] }, { "Id": 15, "label": "2. Hexatónicas", "children": [ { "Id": 25, "label": "2.1. Tonos enteros (Modo I de transposición limitada, Messian)", "children": [ { "Id": 26, "label": "2.1.1. TE0 (0-2-4-6-8-10)" }, { "Id": 27, "label": "2.1.2. TE1 (1-3-5-7-9-11)" } ] }, { "Id": 28, "label": "2.2. Escala de blues (1 b3 4 #4/b5 5 b7)" }, { "Id": 29, "label": "2.3. Aumentada", "children": [ { "Id": 30, "label": "2.3.1. HEX 0,1 (0-1-4-5-8-9)" }, { "Id": 31, "label": "2.3.2. HEX 1,2 (1-2-5-6-9-10)" }, { "Id": 32, "label": "2.3.3. HEX 2,3 (2-3-6-7-10-11)" }, { "Id": 33, "label": "2.3.4. HEX 3,4 (3-4-7-8-11-0)" } ] }, { "Id": 34, "label": "2.4. Modo de transposición limitada V, Messian (0-1-5-6-7-11)" } ] }, { "Id": 16, "label": "3. Heptatónicas", "children": [ { "Id": 35, "label": "3.1. Mayor" }, { "Id": 36, "label": "3.2. Menor", "children": [ { "Id": 37, "label": "3.2.1. Natural" }, { "Id": 38, "label": "3.2.2. Armónica" }, { "Id": 39, "label": "3.2.3. Melódica" } ] }, { "Id": 40, "label": "3.3. Modos diatónicos", "children": [ { "Id": 41, "label": "3.3.1. Jónica" }, { "Id": 42, "label": "3.3.2. Dórica" }, { "Id": 43, "label": "3.3.3. Lidia" }, { "Id": 44, "label": "3.3.4. Mixolidia" }, { "Id": 45, "label": "3.3.5. Eólica" }, { "Id": 46, "label": "3.3.6. Locria" } ] }, { "Id": 47, "label": "3.4. Lidia-Mixolidia (1 2 3 #4 5 6 b7)" }, { "Id": 48, "label": "3.5. Modos gregorianos", "children": [ { "Id": 49, "label": "3.5.1. Auténticos" }, { "Id": 50, "label": "3.5.2. Plagales" } ] } ] }, { "Id": 17, "label": "4. Octatónicas", "children": [ { "Id": 51, "label": "4.1. Disminuida (Modo II de transposición limitada, Messian)", "children": [ { "Id": 52, "label": "4.1.1. OCT 0,1 (0-1-3-4-6-7-9-10)" }, { "Id": 53, "label": "4.1.2. OCT 1,2 (1-2-4-5-7-8-10-11)" }, { "Id": 54, "label": "4.1.3. OCT 2,3 (2-3-5-6-8-9-11-0)" } ] }, { "Id": 55, "label": "4.2. BeeBop (1 2 3 4 5 6 b7 7)" }, { "Id": 56, "label": "4.3. Modo de transposición limitada IV, Messian (0-1-2-5-6-7-8-11)" }, { "Id": 57, "label": "4.4. Modo de transposición limitada VI, Messian (0-2-4-5-6-8-10-11)" } ] }, { "Id": 18, "label": "5. Nonatónicas", "children": [ { "Id": 58, "label": "5.1. Modo de transposición limitada III, Messian (0-2-3-4-6-7-8-10-11)" } ] }, { "Id": 19, "label": "6. Decatónicas", "children": [ { "Id": 59, "label": "6.1. Modo de transposición limitada VII, Messian (0-1-2-3-5-6-7-8-9-11)" } ] } ] }, { "Id": 2, "label": "Acordes (tipos)", "children": [ { "Id": 60, "label": "1. Triadas", "children": [ { "Id": 63, "label": "1.1. Mayor" }, { "Id": 64, "label": "1.2. Menor" }, { "Id": 65, "label": "1.3. Aumentada" }, { "Id": 66, "label": "1.4. Disminuida" }, { "Id": 67, "label": "1.5. Sus4" }, { "Id": 68, "label": "1.6. Sus2" } ] }, { "Id": 61, "label": "2. Tetradas", "children": [ { "Id": 69, "label": "2.1. Séptima mayor (mayor mayor)" }, { "Id": 70, "label": "2.2. Séptima menor (menor menor)" }, { "Id": 71, "label": "2.3. Séptima de dominante (mayor menor)" }, { "Id": 72, "label": "2.4. Medio disminuida (disminuido menor)" }, { "Id": 73, "label": "2.5. Disminuida (disminuido disminuido)" }, { "Id": 74, "label": "2.6. Menor-Mayor" }, { "Id": 75, "label": "2.7. Aumentada-Mayor" } ] }, { "Id": 62, "label": "3. Armonía extendida", "children": [ { "Id": 76, "label": "3.1. Acordes de novena" }, { "Id": 77, "label": "3.2. Acorde de undécima" }, { "Id": 78, "label": "3.3. Acordes decimotercera" }, { "Id": 79, "label": "3.4. Acordes con sexta agregada" }, { "Id": 80, "label": "3.5. Acordes sin tercera (power chords)" }, { "Id": 81, "label": "3.6. Acordes cuartales" }, { "Id": 82, "label": "3.7. Poliacordes" } ] } ] }, { "Id": 3, "label": "Chord scales", "children": [ { "Id": 83, "label": "1. I7 y I6 (jónico)" }, { "Id": 84, "label": "2. ii7 (dórico)" }, { "Id": 85, "label": "3. iii7 (frigio)" }, { "Id": 86, "label": "4. IV7 (lidio)" }, { "Id": 87, "label": "5. V7 (mixolidio)" }, { "Id": 88, "label": "6. vi7 (eólico)" }, { "Id": 89, "label": "7. vii7(b5) (locrio)" } ] }, { "Id": 4, "label": "Funciones armónicas", "children": [ { "Id": 90, "label": "1. Tónica" }, { "Id": 91, "label": "2. Subdominante" }, { "Id": 92, "label": "3. Dominante" } ] }, { "Id": 5, "label": "Cadencias", "children": [ { "Id": 93, "label": "1. Armónicas", "children": [ { "Id": 95, "label": "1.1. Conclusivas", "children": [ { "Id": 96, "label": "1.1.1. Auténtica perfecta" }, { "Id": 97, "label": "1.1.2. Auténtica imperfecta" }, { "Id": 98, "label": "1.1.3. Plagal" }, { "Id": 99, "label": "1.1.4. Landini" } ] }, { "Id": 100, "label": "1.2. Semi-conclusivas", "children": [ { "Id": 101, "label": "1.2.1. Semicadencia auténtica" }, { "Id": 102, "label": "1.2.2. Semicadencia plagal" } ] }, { "Id": 103, "label": "1.3. Desviaciones cadenciales", "children": [ { "Id": 104, "label": "1.3.1. Auténtica deceptiva (rota)" }, { "Id": 105, "label": "1.3.2. Plagal deceptiva" }, { "Id": 106, "label": "1.3.3. Evadida" }, { "Id": 107, "label": "1.3.4. Abandonada" } ] } ] }, { "Id": 94, "label": "2. Melódicas", "children": [ { "Id": 108, "label": "2.1. Conclusivas" }, { "Id": 109, "label": "2.2. Semi-conclusivas" }, { "Id": 110, "label": "2.3. No-conclusivas" } ] } ] }, { "Id": 6, "label": "Texturas", "children": [ { "Id": 111, "label": "1. Monofónica" }, { "Id": 112, "label": "2. Homofónica" }, { "Id": 113, "label": "3. Polifónica" } ] }, { "Id": 7, "label": "Disposiciones", "children": [ { "Id": 114, "label": "1. 4 voces", "children": [ { "Id": 116, "label": "1.1. abierta" }, { "Id": 117, "label": "1.2. cerrada" }, { "Id": 118, "label": "1.3. mixta" } ] }, { "Id": 115, "label": "2. 5 voces", "children": [ { "Id": 119, "label": "2.1. spread voicing" }, { "Id": 120, "label": "2.2. close voicing" } ] } ] }, { "Id": 8, "label": "Notas ornamentales", "children": [ { "Id": 121, "label": "1. Notas de paso" }, { "Id": 122, "label": "2. Bordaduras" }, { "Id": 123, "label": "3. Anticipaciones" }, { "Id": 124, "label": "4. Suspensiones" }, { "Id": 125, "label": "5. Retardaciones" }, { "Id": 126, "label": "6. Pedal" } ] }, { "Id": 9, "label": "Movimiento relativo", "children": [ { "Id": 127, "label": "1. paralelo" }, { "Id": 128, "label": "2. directo" }, { "Id": 129, "label": "3. contrario" }, { "Id": 130, "label": "4. Oblicuo" } ] }, { "Id": 10, "label": "Progresiones armónicas", "children": [ { "Id": 131, "label": "1. Arquetípicas", "children": [ { "Id": 133, "label": "1.1. “Two-five” (ii7-V7-I)" }, { "Id": 134, "label": "1.2. Turn around (iii-vi-ii-V-I)" }, { "Id": 135, "label": "1.3. Círculo de quintas descendentes" }, { "Id": 136, "label": "1.4. T-S-D-T (progresión auténtica)" }, { "Id": 137, "label": "1.5. T-D-S-T (progresión plagal)" }, { "Id": 138, "label": "1.6. “Double plagal” (I-bVII-IV-I)" }, { "Id": 139, "label": "1.7. “Best seller” (I-V-vi-IV)" }, { "Id": 140, "label": "1.8. i-bVII-bVI-bVII-i" }, { "Id": 141, "label": "1.9. bVI-bVII-i" }, { "Id": 142, "label": "1.10. 12-bar blues" }, { "Id": 143, "label": "1.11. Prolongacional interpolado (EPM)" }, { "Id": 144, "label": "1.12. Ciclos octatónicos" }, { "Id": 145, "label": "1.13. Ciclos hexatónicos" } ] }, { "Id": 132, "label": "2. Secuenciales", "children": [ { "Id": 146, "label": "2.1. De quintas", "children": [ { "Id": 149, "label": "2.1.1. Ascendentes" }, { "Id": 150, "label": "2.1.2. Descendentes" } ] }, { "Id": 147, "label": "2.2. De segundas", "children": [ { "Id": 151, "label": "2.2.1. Ascendentes" }, { "Id": 152, "label": "2.2.2. Descendentes" } ] }, { "Id": 148, "label": "2.3. De terceras", "children": [ { "Id": 153, "label": "2.3.1. Ascendentes" }, { "Id": 154, "label": "2.3.2. Descendentes" } ] } ] } ] }, { "Id": 11, "label": "Modulación", "children": [ { "Id": 155, "label": "1. Diatónica (acorde común)" }, { "Id": 156, "label": "2. Cromática" }, { "Id": 157, "label": "3. Enarmónica" }, { "Id": 158, "label": "4. Directa" }, { "Id": 159, "label": "5. Secuencial" } ] }, { "Id": 12, "label": "Transformaciones Neo-riemannianas", "children": [ { "Id": 160, "label": "1. Simples", "children": [ { "Id": 161, "label": "1.1. Primarias", "children": [ { "Id": 162, "label": "1.1.1. P" }, { "Id": 163, "label": "1.1.2. L" }, { "Id": 164, "label": "1.1.3. R" } ] }, { "Id": 165, "label": "1.2. Secundarias", "children": [ { "Id": 166, "label": "1.2.1. S" }, { "Id": 167, "label": "1.2.2. N" }, { "Id": 168, "label": "1.2.3. R1" }, { "Id": 169, "label": "1.2.4. H" } ] } ] }, { "Id": 170, "label": "2. Compuestas" } ] }, { "Id": 13, "label": "Conducción de voces tradicional", "children": [ { "Id": 171, "label": "1. Enlaces sin movimiento paralelo entre consonancias perfectas (i.e., 5tas y 8vas paralelas y antiparalelas)" }, { "Id": 172, "label": "2. Enlaces sin movimiento directo hacia consonancias perfectas (i.e., 5tas y 8vas ocultas)" }, { "Id": 173, "label": "3. Enlaces sin movimiento paralelo entre 5tas de distintas calidad (i.e. 5tas desiguales)" }, { "Id": 174, "label": "4. Enlaces con tratamiento regular e irregular de la sensible" }, { "Id": 175, "label": "5. Tratamiento regular de la disonancia" }, { "Id": 176, "label": "6. Resolución irregular de la disonancia (diferida e indirecta)" }, { "Id": 177, "label": "7. Enlaces con y sin cruzamiento de voces" }, { "Id": 178, "label": "8. Conducción armónica paralela (planning)" } ] } ];
    this.ejemploCategoria = [
      {
        "id": 1,
        "ejemploId": 1,
        "categoriaId": 20
      },
      {
        "id": 2,
        "ejemploId": 2,
        "categoriaId": 21
      },
      {
        "id": 3,
        "ejemploId": 3,
        "categoriaId": 22
      }
    ];
    this.ejemplos = [
    {
      "id": 1,
      "nombre": "Ejemplo 1",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/brainwork-254155.mp3",
      "descripcion": "https://github.com/Faez777/base-musical/raw/main/assets/Práctica encuadres.pdf"
    },
    {
      "id": 2,
      "nombre": "Ejemplo 2",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/intro-rampb-instrumental-loop-244659.mp3",
      "descripcion": "https://github.com/Faez777/base-musical/raw/main/assets/images.png"
    },
    {
      "id": 3,
      "nombre": "Ejemplo 3",
      "rutaArchivo": "https://github.com/Faez777/base-musical/raw/main/assets/magiksolo-beginning-investigation-232340.mp3",
      "descripcion": "https://github.com/Faez777/base-musical/raw/main/assets/traducir-notas-partituras-piano.png.jpg"
    }
  ];

    this.musicalCategories = [ { "id": 1, "name": "Escalas", "parentId": null }, { "id": 2, "name": "Acordes (tipos)", "parentId": null }, { "id": 3, "name": "Chord scales", "parentId": null }, { "id": 4, "name": "Funciones armónicas", "parentId": null }, { "id": 5, "name": "Cadencias", "parentId": null }, { "id": 6, "name": "Texturas", "parentId": null }, { "id": 7, "name": "Disposiciones", "parentId": null }, { "id": 8, "name": "Notas ornamentales", "parentId": null }, { "id": 9, "name": "Movimiento relativo", "parentId": null }, { "id": 10, "name": "Progresiones armónicas", "parentId": null }, { "id": 11, "name": "Modulación", "parentId": null }, { "id": 12, "name": "Transformaciones Neo-riemannianas", "parentId": null }, { "id": 13, "name": "Conducción de voces tradicional", "parentId": null }, { "id": 14, "name": "1. Pentatónicas", "parentId": 1 }, { "id": 15, "name": "2. Hexatónicas", "parentId": 1 }, { "id": 16, "name": "3. Heptatónicas", "parentId": 1 }, { "id": 17, "name": "4. Octatónicas", "parentId": 1 }, { "id": 18, "name": "5. Nonatónicas", "parentId": 1 }, { "id": 19, "name": "6. Decatónicas", "parentId": 1 }, { "id": 20, "name": "1.1. Modo I (mayor): 1 2 3 5 6", "parentId": 14 }, { "id": 21, "name": "1.2. Modo II: 2 3 5 6 1", "parentId": 14 }, { "id": 22, "name": "1.3. Modo III: 3 5 6 1 2", "parentId": 14 }, { "id": 23, "name": "1.4. Modo IV: 5 6 1 2 3", "parentId": 14 }, { "id": 24, "name": "1.5. Modo V (menor): 6 1 2 3 5", "parentId": 14 }, { "id": 25, "name": "2.1. Tonos enteros (Modo I de transposición limitada, Messian)", "parentId": 15 }, { "id": 26, "name": "2.1.1. TE0 (0-2-4-6-8-10)", "parentId": 25 }, { "id": 27, "name": "2.1.2. TE1 (1-3-5-7-9-11)", "parentId": 25 }, { "id": 28, "name": "2.2. Escala de blues (1 b3 4 #4/b5 5 b7)", "parentId": 15 }, { "id": 29, "name": "2.3. Aumentada", "parentId": 15 }, { "id": 30, "name": "2.3.1. HEX 0,1 (0-1-4-5-8-9)", "parentId": 29 }, { "id": 31, "name": "2.3.2. HEX 1,2 (1-2-5-6-9-10)", "parentId": 29 }, { "id": 32, "name": "2.3.3. HEX 2,3 (2-3-6-7-10-11)", "parentId": 29 }, { "id": 33, "name": "2.3.4. HEX 3,4 (3-4-7-8-11-0)", "parentId": 29 }, { "id": 34, "name": "2.4. Modo de transposición limitada V, Messian (0-1-5-6-7-11)", "parentId": 15 }, { "id": 35, "name": "3.1. Mayor", "parentId": 16 }, { "id": 36, "name": "3.2. Menor", "parentId": 16 }, { "id": 37, "name": "3.2.1. Natural", "parentId": 36 }, { "id": 38, "name": "3.2.2. Armónica", "parentId": 36 }, { "id": 39, "name": "3.2.3. Melódica", "parentId": 36 }, { "id": 40, "name": "3.3. Modos diatónicos", "parentId": 16 }, { "id": 41, "name": "3.3.1. Jónica", "parentId": 40 }, { "id": 42, "name": "3.3.2. Dórica", "parentId": 40 }, { "id": 43, "name": "3.3.3. Lidia", "parentId": 40 }, { "id": 44, "name": "3.3.4. Mixolidia", "parentId": 40 }, { "id": 45, "name": "3.3.5. Eólica", "parentId": 40 }, { "id": 46, "name": "3.3.6. Locria", "parentId": 40 }, { "id": 47, "name": "3.4. Lidia-Mixolidia (1 2 3 #4 5 6 b7)", "parentId": 16 }, { "id": 48, "name": "3.5. Modos gregorianos", "parentId": 16 }, { "id": 49, "name": "3.5.1. Auténticos", "parentId": 48 }, { "id": 50, "name": "3.5.2. Plagales", "parentId": 48 }, { "id": 51, "name": "4.1. Disminuida (Modo II de transposición limitada, Messian)", "parentId": 17 }, { "id": 52, "name": "4.1.1. OCT 0,1 (0-1-3-4-6-7-9-10)", "parentId": 51 }, { "id": 53, "name": "4.1.2. OCT 1,2 (1-2-4-5-7-8-10-11)", "parentId": 51 }, { "id": 54, "name": "4.1.3. OCT 2,3 (2-3-5-6-8-9-11-0)", "parentId": 51 }, { "id": 55, "name": "4.2. BeeBop (1 2 3 4 5 6 b7 7)", "parentId": 17 }, { "id": 56, "name": "4.3. Modo de transposición limitada IV, Messian (0-1-2-5-6-7-8-11)", "parentId": 17 }, { "id": 57, "name": "4.4. Modo de transposición limitada VI, Messian (0-2-4-5-6-8-10-11)", "parentId": 17 }, { "id": 58, "name": "5.1. Modo de transposición limitada III, Messian (0-2-3-4-6-7-8-10-11)", "parentId": 18 }, { "id": 59, "name": "6.1. Modo de transposición limitada VII, Messian (0-1-2-3-5-6-7-8-9-11)", "parentId": 19 }, { "id": 60, "name": "1. Triadas", "parentId": 2 }, { "id": 61, "name": "2. Tetradas", "parentId": 2 }, { "id": 62, "name": "3. Armonía extendida", "parentId": 2 }, { "id": 63, "name": "1.1. Mayor", "parentId": 60 }, { "id": 64, "name": "1.2. Menor", "parentId": 60 }, { "id": 65, "name": "1.3. Aumentada", "parentId": 60 }, { "id": 66, "name": "1.4. Disminuida", "parentId": 60 }, { "id": 67, "name": "1.5. Sus4", "parentId": 60 }, { "id": 68, "name": "1.6. Sus2", "parentId": 60 }, { "id": 69, "name": "2.1. Séptima mayor (mayor mayor)", "parentId": 61 }, { "id": 70, "name": "2.2. Séptima menor (menor menor)", "parentId": 61 }, { "id": 71, "name": "2.3. Séptima de dominante (mayor menor)", "parentId": 61 }, { "id": 72, "name": "2.4. Medio disminuida (disminuido menor)", "parentId": 61 }, { "id": 73, "name": "2.5. Disminuida (disminuido disminuido)", "parentId": 61 }, { "id": 74, "name": "2.6. Menor-Mayor", "parentId": 61 }, { "id": 75, "name": "2.7. Aumentada-Mayor", "parentId": 61 }, { "id": 76, "name": "3.1. Acordes de novena", "parentId": 62 }, { "id": 77, "name": "3.2. Acorde de undécima", "parentId": 62 }, { "id": 78, "name": "3.3. Acordes decimotercera", "parentId": 62 }, { "id": 79, "name": "3.4. Acordes con sexta agregada", "parentId": 62 }, { "id": 80, "name": "3.5. Acordes sin tercera (power chords)", "parentId": 62 }, { "id": 81, "name": "3.6. Acordes cuartales", "parentId": 62 }, { "id": 82, "name": "3.7. Poliacordes", "parentId": 62 }, { "id": 83, "name": "1. I7 y I6 (jónico)", "parentId": 3 }, { "id": 84, "name": "2. ii7 (dórico)", "parentId": 3 }, { "id": 85, "name": "3. iii7 (frigio)", "parentId": 3 }, { "id": 86, "name": "4. IV7 (lidio)", "parentId": 3 }, { "id": 87, "name": "5. V7 (mixolidio)", "parentId": 3 }, { "id": 88, "name": "6. vi7 (eólico)", "parentId": 3 }, { "id": 89, "name": "7. vii7(b5) (locrio)", "parentId": 3 }, { "id": 90, "name": "1. Tónica", "parentId": 4 }, { "id": 91, "name": "2. Subdominante", "parentId": 4 }, { "id": 92, "name": "3. Dominante", "parentId": 4 }, { "id": 93, "name": "1. Armónicas", "parentId": 5 }, { "id": 94, "name": "2. Melódicas", "parentId": 5 }, { "id": 95, "name": "1.1. Conclusivas", "parentId": 93 }, { "id": 96, "name": "1.1.1. Auténtica perfecta", "parentId": 95 }, { "id": 97, "name": "1.1.2. Auténtica imperfecta", "parentId": 95 }, { "id": 98, "name": "1.1.3. Plagal", "parentId": 95 }, { "id": 99, "name": "1.1.4. Landini", "parentId": 95 }, { "id": 100, "name": "1.2. Semi-conclusivas", "parentId": 93 }, { "id": 101, "name": "1.2.1. Semicadencia auténtica", "parentId": 100 }, { "id": 102, "name": "1.2.2. Semicadencia plagal", "parentId": 100 }, { "id": 103, "name": "1.3. Desviaciones cadenciales", "parentId": 93 }, { "id": 104, "name": "1.3.1. Auténtica deceptiva (rota)", "parentId": 103 }, { "id": 105, "name": "1.3.2. Plagal deceptiva", "parentId": 103 }, { "id": 106, "name": "1.3.3. Evadida", "parentId": 103 }, { "id": 107, "name": "1.3.4. Abandonada", "parentId": 103 }, { "id": 108, "name": "2.1. Conclusivas", "parentId": 94 }, { "id": 109, "name": "2.2. Semi-conclusivas", "parentId": 94 }, { "id": 110, "name": "2.3. No-conclusivas", "parentId": 94 }, { "id": 111, "name": "1. Monofónica", "parentId": 6 }, { "id": 112, "name": "2. Homofónica", "parentId": 6 }, { "id": 113, "name": "3. Polifónica", "parentId": 6 }, { "id": 114, "name": "1. 4 voces", "parentId": 7 }, { "id": 115, "name": "2. 5 voces", "parentId": 7 }, { "id": 116, "name": "1.1. abierta", "parentId": 114 }, { "id": 117, "name": "1.2. cerrada", "parentId": 114 }, { "id": 118, "name": "1.3. mixta", "parentId": 114 }, { "id": 119, "name": "2.1. spread voicing", "parentId": 115 }, { "id": 120, "name": "2.2. close voicing", "parentId": 115 }, { "id": 121, "name": "1. Notas de paso", "parentId": 8 }, { "id": 122, "name": "2. Bordaduras", "parentId": 8 }, { "id": 123, "name": "3. Anticipaciones", "parentId": 8 }, { "id": 124, "name": "4. Suspensiones", "parentId": 8 }, { "id": 125, "name": "5. Retardaciones", "parentId": 8 }, { "id": 126, "name": "6. Pedal", "parentId": 8 }, { "id": 127, "name": "1. paralelo", "parentId": 9 }, { "id": 128, "name": "2. directo", "parentId": 9 }, { "id": 129, "name": "3. contrario", "parentId": 9 }, { "id": 130, "name": "4. Oblicuo", "parentId": 9 }, { "id": 131, "name": "1. Arquetípicas", "parentId": 10 }, { "id": 132, "name": "2. Secuenciales", "parentId": 10 }, { "id": 133, "name": "1.1. “Two-five” (ii7-V7-I)", "parentId": 131 }, { "id": 134, "name": "1.2. \"Turn around\"(iii-vi-ii-V-I)", "parentId": 131 }, { "id": 135, "name": "1.3. Círculo de quintas descendentes", "parentId": 131 }, { "id": 136, "name": "1.4. T-S-D-T (progresión auténtica)", "parentId": 131 }, { "id": 137, "name": "1.5. T-D-S-T (progresión plagal)", "parentId": 131 }, { "id": 138, "name": "1.6. “Double plagal” (I-bVII-IV-I)", "parentId": 131 }, { "id": 139, "name": "1.7. “Best seller” (I-V-vi-IV)", "parentId": 131 }, { "id": 140, "name": "1.8. i-bVII-bVI-bVII-i", "parentId": 131 }, { "id": 141, "name": "1.9. bVI-bVII-i", "parentId": 131 }, { "id": 142, "name": "1.10. 12-bar blues", "parentId": 131 }, { "id": 143, "name": "1.11. Prolongacional interpolado (EPM)", "parentId": 131 }, { "id": 144, "name": "1.12. Ciclos octatónicos", "parentId": 131 }, { "id": 145, "name": "1.13. Ciclos hexatónicos", "parentId": 131 }, { "id": 146, "name": "2.1. De quintas", "parentId": 132 }, { "id": 147, "name": "2.2. De segundas", "parentId": 132 }, { "id": 148, "name": "2.3. De terceras", "parentId": 132 }, { "id": 149, "name": "2.1.1. Ascendentes", "parentId": 146 }, { "id": 150, "name": "2.1.2. Descendentes", "parentId": 146 }, { "id": 151, "name": "2.2.1. Ascendentes", "parentId": 147 }, { "id": 152, "name": "2.2.2. Descendentes", "parentId": 147 }, { "id": 153, "name": "2.3.1. Ascendentes", "parentId": 148 }, { "id": 154, "name": "2.3.2. Descendentes", "parentId": 148 }, { "id": 155, "name": "1. Diatónica (acorde común)", "parentId": 11 }, { "id": 156, "name": "2. Cromática", "parentId": 11 }, { "id": 157, "name": "3. Enarmónica", "parentId": 11 }, { "id": 158, "name": "4. Directa", "parentId": 11 }, { "id": 159, "name": "5. Secuencial", "parentId": 11 }, { "id": 160, "name": "1. Simples", "parentId": 12 }, { "id": 161, "name": "1.1. Primarias", "parentId": 160 }, { "id": 162, "name": "1.1.1. P", "parentId": 161 }, { "id": 163, "name": "1.1.2. L", "parentId": 161 }, { "id": 164, "name": "1.1.3. R", "parentId": 161 }, { "id": 165, "name": "1.2. Secundarias", "parentId": 160 }, { "id": 166, "name": "1.2.1. S", "parentId": 165 }, { "id": 167, "name": "1.2.2. N", "parentId": 165 }, { "id": 168, "name": "1.2.3. R1", "parentId": 165 }, { "id": 169, "name": "1.2.4. H", "parentId": 165 }, { "id": 170, "name": "2. Compuestas", "parentId": 12 }, { "id": 171, "name": "1. Enlaces sin movimiento paralelo entre consonancias perfectas (i.e., 5tas y 8vas paralelas y antiparalelas)", "parentId": 13 }, { "id": 172, "name": "2. Enlaces sin movimiento directo hacia consonancias perfectas (i.e., 5tas y 8vas ocultas)", "parentId": 13 }, { "id": 173, "name": "3. Enlaces sin movimiento paralelo entre 5tas de distintas calidad (i.e. 5tas desiguales)", "parentId": 13 }, { "id": 174, "name": "4. Enlaces con tratamiento regular e irregular de la sensible", "parentId": 13 }, { "id": 175, "name": "5. Tratamiento regular de la disonancia", "parentId": 13 }, { "id": 176, "name": "6. Resolución irregular de la disonancia (diferida e indirecta)", "parentId": 13 }, { "id": 177, "name": "7. Enlaces con y sin cruzamiento de voces", "parentId": 13 }, { "id": 178, "name": "8. Conducción armónica paralela (planning)", "parentId": 13 } ];
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
.music-filter {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}

.music-filter h2 {
  text-align: center;
  margin-bottom: 20px;
}

.filter-container {
  display: flex; /* Utiliza flexbox para la disposición en línea */
  justify-content: space-between; /* Espacio entre los elementos */
}

.dynamic-tree {
  flex: 1; /* Permite que el árbol ocupe el espacio disponible */
  margin-right: 200px; /* Aumenta el espacio entre el árbol y los elementos seleccionados */
}

.selected-items {
  min-width: 200px; /* Ancho mínimo para la sección de elementos seleccionados */
}

.music-filter ul {
  list-style-type: none;
  padding: 0;
}

.music-filter li {
  background-color: #f0f0f0;
  margin-bottom: 5px;
  padding: 10px;
  border-radius: 5px;
}

.tree-select {
  width: 100%; /* Asegura que el componente ocupe todo el ancho */
}

.remove-item {
  color: red;
  cursor: pointer;
  margin-left: 10px;
  font-weight: bold;
}

.remove-item:hover {
  color: darkred;
}
</style>



