import Vue from 'vue';
import Buefy from 'buefy';
import * as Sentry from '@sentry/browser';
import { Vue as VueIntegration } from '@sentry/integrations';

import 'buefy/dist/buefy.css';

import App from './App.vue';
import router from './router';
import store from './store';

import { version } from '../package.json';

Vue.use(Buefy, { defaultIconPack: 'fas' });

Vue.config.productionTip = false;

Sentry.init({
  dsn: process.env.VUE_APP_SENTRY_DSN,
  release: version,
  integrations: [new VueIntegration({ Vue, attachProps: true })],
});

Sentry.configureScope((scope) => {
  scope.setTag('instance', process.env.VUE_APP_INSTANCE);
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount('#app');
