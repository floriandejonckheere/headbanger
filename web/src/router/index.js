import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../views/Home.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/discover',
    name: 'discover',
    component: () => import(/* webpackChunkName: "discover" */ '../views/Discover.vue'),
  },
  {
    path: '/browse',
    name: 'browse',
    component: () => import(/* webpackChunkName: "browse" */ '../views/Browse.vue'),
  },
  {
    path: '/search',
    name: 'search',
    component: () => import(/* webpackChunkName: "search" */ '../views/Search.vue'),
  },

  // Genres
  {
    path: '/browse/genres',
    name: 'genres',
    component: () => import(/* webpackChunkName: "genres" */ '../views/browse/Genres.vue'),
  },
  {
    path: '/browse/genres/:id',
    name: 'genre',
    component: () => import(/* webpackChunkName: "genre" */ '../views/browse/Genre.vue'),
    props: true,
  },

  // Artists
  {
    path: '/browse/artists/:id',
    name: 'artist',
    component: () => import(/* webpackChunkName: "artist" */ '../views/browse/Artist.vue'),
    props: true,
  },

  // Authentication
  {
    path: '/auth/signin',
    name: 'signin',
    component: () => import(/* webpackChunkName: "signin" */ '../views/auth/Signin.vue'),
  },
  {
    path: '/auth/signup',
    name: 'signup',
    component: () => import(/* webpackChunkName: "signup" */ '../views/auth/Signup.vue'),
  },

  // Catchall
  {
    path: '*',
    name: 'not_found',
    component: () => import(/* webpackChunkName: "not_found" */ '../views/errors/NotFound.vue'),
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  linkActiveClass: 'uk-active',
  routes,
});

export default router;
