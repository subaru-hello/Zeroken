const { environment } = require('@rails/webpacker')
const customConfig = {
    resolve: {
        fallback: {
        dgram: false,
        fs: false,
        net: false,
        tls: false,
        child_process: false
      }
    },
    module:{
      rules:[
        {
          test: /\.(png|jpe?g|gif|svg|woff|woff2|ttf|eot|ico)$/,
          use: 'file-loader?name=assets/[name].[hash].[ext]'
        }
      ]
    }
  };
  
  environment.config.delete('node.dgram')
  environment.config.delete('node.fs')
  environment.config.delete('node.net')
  environment.config.delete('node.tls')
  environment.config.delete('node.child_process')

  environment.config.merge(customConfig);
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment
