import Vue from 'vue';
import UIkit from 'uikit';
import * as Sentry from '@sentry/browser';
import { Vue as VueIntegration } from '@sentry/integrations';

import '@/assets/styles/styles.scss';
import Icons from 'uikit/dist/js/uikit-icons';

import App from './App.vue';
import router from './router';
import store from './store';

import { version } from '../package.json';
import { createProvider } from './vue-apollo';

UIkit.use(Icons);
window.UIkit = UIkit;

Vue.config.productionTip = false;
Vue.config.ignoredElements = [/^ion-/];

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
