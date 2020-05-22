const path = require('path');

module.exports = {
  pluginOptions: {
    apollo: {
      lintGQL: true,
    },
  },
  configureWebpack: {
    resolve: {
      alias: {
        styles: path.resolve(__dirname, './src/assets/styles/'),
      },
    },
  },
};
