import Vue from 'vue';
import UIkit from 'uikit';

import * as Sentry from '@sentry/browser';
import { Vue as VueIntegration } from '@sentry/integrations';
import { Integrations } from '@sentry/tracing';

import InfiniteLoading from 'vue-infinite-loading';

import 'vue-ionicons/ionicons.css';
import AllIosIcon from 'vue-ionicons/dist/ionicons-ios';

import '@/assets/styles/styles.scss';
import Icons from 'uikit/dist/js/uikit-icons';

import App from './App.vue';
import router from './router';
import store from './store';

import { version } from '../package.json';
import { createProvider } from './vue-apollo';

UIkit.use(Icons);
window.UIkit = UIkit;

Vue.use(InfiniteLoading);
Vue.use(AllIosIcon);

Vue.config.productionTip = false;

Sentry.init({
  dsn: process.env.VUE_APP_SENTRY_DSN,
  release: version,
  integrations: [
    new VueIntegration({
      Vue,
      tracing: true,
      logErrors: true,
    }),
    new Integrations.BrowserTracing(),
  ],
  tracesSampleRate: 1,
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
