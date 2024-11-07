<template>
    <div class="music-filter">
      <h2>Filtrar Ejemplos Musicales</h2>
      <el-tree-select
        v-model="selectedItems"
        :data="musicalOptions"
        :multiple="true"
        :check-strictly="true"
        placeholder="Selecciona acordes, escalas, funciones armónicas..."
        :clearable="true"
        :default-expand-all="true"
      >
      </el-tree-select>
  
      <div v-if="selectedItems.length > 0">
        <h3>Elementos seleccionados:</h3>
        <ul>
          <li v-for="item in selectedItems" :key="item">{{ item }}</li>
        </ul>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: "MusicFilter",
    data() {
      return {
        selectedItems: [],
        musicalOptions: [
          {
            label: "Acordes (tipos)",
            children: [
              {
                label: "Triadas",
                children: [
                  { label: "Mayor", value: "Mayor" },
                  { label: "Menor", value: "Menor" },
                  { label: "Aumentada", value: "Aumentada" },
                  { label: "Disminuida", value: "Disminuida" },
                  { label: "Sus4", value: "Sus4" },
                  { label: "Sus2", value: "Sus2" }
                ]
              },
              {
                label: "Tetradas",
                children: [
                  { label: "Séptima mayor", value: "Séptima mayor" },
                  { label: "Séptima menor", value: "Séptima menor" },
                  { label: "Séptima de dominante", value: "Séptima de dominante" },
                  { label: "Medio disminuida", value: "Medio disminuida" },
                  { label: "Disminuida", value: "Disminuida" },
                  { label: "Menor-Mayor", value: "Menor-Mayor" },
                  { label: "Aumentada-Mayor", value: "Aumentada-Mayor" }
                ]
              }
            ]
          },
          {
            label: "Chord scales",
            children: [
              { label: "I7 y I6 (jónico)", value: "I7 y I6 (jónico)" },
              { label: "ii7 (dórico)", value: "ii7 (dórico)" },
              { label: "iii7 (frigio)", value: "iii7 (frigio)" },
              { label: "IV7 (lidio)", value: "IV7 (lidio)" },
              { label: "V7 (mixolidio)", value: "V7 (mixolidio)" },
              { label: "vi7 (eólico)", value: "vi7 (eólico)" },
              { label: "vii7(b5) (locrio)", value: "vii7(b5) (locrio)" }
            ]
          },
          {
            label: "Funciones armónicas",
            children: [
              { label: "Tónica", value: "Tónica" },
              { label: "Subdominante", value: "Subdominante" },
              { label: "Dominante", value: "Dominante" }
            ]
          },
          {
            label: "Cadencias",
            children: [
              {
                label: "Armónicas",
                children: [
                  {
                    label: "Conclusivas",
                    children: [
                      { label: "Auténtica perfecta", value: "Auténtica perfecta" },
                      { label: "Auténtica imperfecta", value: "Auténtica imperfecta" },
                      { label: "Plagal", value: "Plagal" },
                      { label: "Landini", value: "Landini" }
                    ]
                  },
                  {
                    label: "Semi-conclusivas",
                    children: [
                      { label: "Semicadencia auténtica", value: "Semicadencia auténtica" },
                      { label: "Semicadencia plagal", value: "Semicadencia plagal" }
                    ]
                  },
                  {
                    label: "Desviaciones cadenciales",
                    children: [
                      { label: "Auténtica deceptiva", value: "Auténtica deceptiva" },
                      { label: "Plagal deceptiva", value: "Plagal deceptiva" },
                      { label: "Evadida", value: "Evadida" },
                      { label: "Abandonada", value: "Abandonada" }
                    ]
                  }
                ]
              },
              {
                label: "Melódicas",
                children: [
                  { label: "Conclusivas", value: "Conclusivas" },
                  { label: "Semi-conclusivas", value: "Semi-conclusivas" },
                  { label: "No-conclusivas", value: "No-conclusivas" }
                ]
              }
            ]
          }
        ]
      };
    }
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
  </style>
  