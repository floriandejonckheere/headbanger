import Vue from 'vue';
import Vuikit from 'vuikit';
import VuikitIcons from '@vuikit/icons';
import * as Sentry from '@sentry/browser';
import { Vue as VueIntegration } from '@sentry/integrations';

import '@vuikit/theme';

import App from './App.vue';
import router from './router';
import store from './store';

import { version } from '../package.json';
import { createProvider } from './vue-apollo';

Vue.use(Vuikit);
Vue.use(VuikitIcons);

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
  apolloProvider: createProvider(),
  render: (h) => h(App),
}).$mount('#app');
