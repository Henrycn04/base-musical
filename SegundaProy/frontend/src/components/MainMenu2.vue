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
    <ul>
      <li v-for="example in examples" :key="example.Nombre">
        {{ example.nombre }} - {{ example.rutaArchivo }}
      </li>
    </ul>
  </div>
  <div v-else>
    <h3>No hay ejemplos disponibles.</h3>
  </div>

</template>


<script>
import axios from 'axios';
export default {
  name: "MusicFilter",
  data() {
    return {
      examples: [],
      selectedItems: [],
      musicalOptions2: [],
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
    async fetchExamples() {

      try {
            console.log("Categorías enviadas:", this.selectedItems); // Verifica qué categorías estás enviando
            // Prepara los parámetros para la solicitud
            const params = {
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
            this.examples = response.data; // Asigna los ejemplos obtenidos a la variable de datos
            console.log("Ejemplos obtenidos:", this.examples); // Verifica la asignación
        } catch (error) {
            console.error("Error al obtener ejemplos:", error);
        }
        }
  },
  async mounted() {
    try {
      const response = await axios.get('https://localhost:7294/api/MusicalCategories/hierarchical');
      this.musicalOptions2 = response.data;  // Asigna los datos que vienen en formato adecuado
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



