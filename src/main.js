import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router' // Importa el router
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import bootstrap from 'bootstrap'

const app = createApp(App)
app.use(ElementPlus);
app.use(router) // Usa el router en la aplicación
app.use(bootstrap)

app.mount('#app')

