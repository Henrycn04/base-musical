import { createRouter, createWebHistory } from 'vue-router'
import MainMenu from '@/components/MainMenu.vue'
import MainMenu2 from '@/components/MainMenu2.vue'
const routes = [
    {
        path: '/',
        name: 'MainMenu2',
        component: MainMenu2
    },
    {
        path: '/hola',
        name: 'MainMenu',
        component: MainMenu
    },
    
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router