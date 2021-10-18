process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const customConfig = {
    resolve: {
      alias: {
        dgram: false,
        fs: false,
        net: false,
        tls: false
      }
    }
  };
  
  environment.config.delete('node.dgram')
  environment.config.delete('node.fs')
  environment.config.delete('node.net')
  environment.config.delete('node.tls')
  environment.config.delete('node.child_process')

  
  environment.config.merge(customConfig);
module.exports = environment.toWebpackConfig()
