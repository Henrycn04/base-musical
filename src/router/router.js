import { createRouter, createWebHashHistory } from 'vue-router'
import MainMenu from '@/components/MainMenu.vue'
import MainMenu2 from '@/components/MainMenu2.vue'
import MainPage from '@/components/MainPage.vue'

const routes = [
    {
        path: '/',
        name: 'MainPage',
        component: MainPage
    },
    {
        path: '/menu2',
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
    history: createWebHashHistory(),
    routes
})

export default router
