const { environment } = require('@rails/webpacker')
const config = environment.toWebpackConfig();
delete(config.optimization.minimizer)

module.exports = config
