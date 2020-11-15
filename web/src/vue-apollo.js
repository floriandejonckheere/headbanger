import Vue from 'vue';
import VueApollo from 'vue-apollo';
import { createApolloClient, restartWebsockets } from 'vue-cli-plugin-apollo/graphql-client';
import { onError } from 'apollo-link-error';
import { setContext } from 'apollo-link-context';
import { InMemoryCache } from 'apollo-cache-inmemory';

import * as Sentry from '@sentry/browser';

import fragmentMatcher from './fragmentMatcher';

// Install the vue plugin
Vue.use(VueApollo);

// Names of the localStorage items
const AUTH_TOKEN = 'apollo-token';
const AUTH_UID = 'apollo-uid';
const AUTH_CLIENT = 'apollo-client';

// Http endpoint
const httpEndpoint = process.env.VUE_APP_GRAPHQL_HTTP || '/graphql';
// Files URL root
export const filesRoot = process.env.VUE_APP_FILES_ROOT || httpEndpoint.substr(0, httpEndpoint.indexOf('/graphql'));

Vue.prototype.$filesRoot = filesRoot;

// Error handling
const errorLink = onError(({ graphQLErrors, networkError }) => {
  if (graphQLErrors) {
    graphQLErrors.forEach(({
      message, locations, path, extensions,
    }) => console.log(`[GraphQL error]: Message: ${message}, Location: ${JSON.stringify(locations)}, Path: ${path}, Extensions: ${JSON.stringify(extensions)}`));
  }
  if (networkError) console.log(`[Network error]: ${networkError}`);
});

// Authentication
const authLink = setContext((operation, { headers }) => {
  const uid = localStorage.getItem(AUTH_UID);
  const token = localStorage.getItem(AUTH_TOKEN);
  const client = localStorage.getItem(AUTH_CLIENT);

  return {
    headers: {
      ...headers,
      uid,
      'access-token': token,
      client,
    },
  };
});

// Config
const defaultOptions = {
  // You can use `https` for secure connection (recommended in production)
  httpEndpoint,

  // You can use `wss` for secure connection (recommended in production)
  // Use `null` to disable subscriptions
  wsEndpoint: null, // process.env.VUE_APP_GRAPHQL_WS || 'ws://localhost:3000/graphql',
  // LocalStorage token
  // tokenName: AUTH_TOKEN,
  // Enable Automatic Query persisting with Apollo Engine
  persisting: false,
  // Use websockets for everything (no HTTP)
  // You need to pass a `wsEndpoint` for this to work
  websocketsOnly: false,
  // Is being rendered on the server?
  ssr: false,

  // Override default apollo link
  // note: don't override httpLink here, specify httpLink options in the
  // httpLinkOptions property of defaultOptions.
  link: authLink.concat(errorLink),

  // Override default cache
  cache: new InMemoryCache({ fragmentMatcher }),

  // Override the way the Authorization header is set
  // getAuth: (tokenName) => { ... },

  // Additional ApolloClient options
  // apollo: { ... }

  // Client local data (see apollo-link-state)
  // clientState: { resolvers: { ... }, defaults: { ... } }
};

// Call this in the Vue app file
export function createProvider(options = {}) {
  // Create apollo client
  const { apolloClient, wsClient } = createApolloClient({
    ...defaultOptions,
    ...options,
  });
  apolloClient.wsClient = wsClient;

  // Create vue apollo provider
  const apolloProvider = new VueApollo({
    defaultClient: apolloClient,
    defaultOptions: {
      $query: {
        errorPolicy: 'all',
        // fetchPolicy: 'cache-and-network',
      },
    },
    errorHandler(error) {
      // eslint-disable-next-line no-console
      console.log('%cError', 'background: red; color: white; padding: 2px 4px; border-radius: 3px; font-weight: bold;', error.message);
      Sentry.captureException(error);
    },
  });

  return apolloProvider;
}

// Manually call this when user logs in
export async function onLogin(apolloClient, { uid, token, client }) {
  if (typeof localStorage !== 'undefined' && token) {
    localStorage.setItem(AUTH_UID, uid);
    localStorage.setItem(AUTH_TOKEN, token);
    localStorage.setItem(AUTH_CLIENT, client);
  }
  if (apolloClient.wsClient) restartWebsockets(apolloClient.wsClient);
  try {
    await apolloClient.resetStore();
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('%cError on cache reset (login)', 'color: orange;', e.message);
  }
}

// Manually call this when user logs out
export async function onLogout(apolloClient) {
  if (typeof localStorage !== 'undefined') {
    localStorage.removeItem(AUTH_UID);
    localStorage.removeItem(AUTH_TOKEN);
    localStorage.removeItem(AUTH_CLIENT);
  }
  if (apolloClient.wsClient) restartWebsockets(apolloClient.wsClient);
  try {
    await apolloClient.resetStore();
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('%cError on cache reset (logout)', 'color: orange;', e.message);
  }
}
