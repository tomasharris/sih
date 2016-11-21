superagent = require('superagent-promise')(require('superagent'), Promise)
# Services
GithubUserService = require './services/githubUserService'

# Main Store
Store   = require './models/store'

# Top Level View
AppView = require './views/appView'

store   = new Store(new GithubUserService(superagent, 'https://api.github.com'))
appView = new AppView(store)

appView.render()

