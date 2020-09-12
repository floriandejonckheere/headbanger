const path = require('path');

const SentryWebpackPlugin = require('@sentry/webpack-plugin');

const package = require('./package.json')

module.exports = {
  pluginOptions: {
    apollo: {
      lintGQL: true,
    },
  },
  devServer: {
    proxy: {
      '/graphql': {
        target: 'http://localhost:3000',
      },
    },
  },
  configureWebpack: {
    resolve: {
      alias: {
        styles: path.resolve(__dirname, './src/assets/styles/'),
      },
    },
    plugins: [
      new SentryWebpackPlugin({
        release: package.version,
        include: './dist',
        ignore: ['node_modules', 'vue.config.js'],
        dryRun: (process.env.NODE_ENV === 'development'),
      }),
    ],
  },
};
