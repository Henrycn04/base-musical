import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router' // Importa el router
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';

const app = createApp(App)
app.use(ElementPlus);
app.use(router) // Usa el router en la aplicación

app.mount('#app')

