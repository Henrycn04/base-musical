<template>
  <v-container>
    <v-treeview
      :items="items"
      item-key="id"
      open-all
      dense
    >
      <template v-slot:label="{ item }">
        <v-icon v-if="item.children && item.children.length" small>mdi-folder</v-icon>
        <v-icon v-else small>mdi-file</v-icon>
        {{ item.name }}
      </template>
    </v-treeview>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      items: [
        {
          id: 1,
          name: 'Root 1',
          children: [
            { id: 2, name: 'Subcategory 1.1' },
            { id: 3, name: 'Subcategory 1.2' }
          ]
        },
        {
          id: 4,
          name: 'Root 2',
          children: [
            { id: 5, name: 'Subcategory 2.1' },
            { id: 6, name: 'Subcategory 2.2' }
          ]
        }
      ]
    };
  }
};
</script>

<style scoped>
.v-treeview-node__label {
  font-weight: bold;
}
</style>
