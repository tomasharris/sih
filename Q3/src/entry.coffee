superagent = require('superagent-promise')(require('superagent'), Promise)
# Services
PeopleService = require './services/peopleService'

# Main Store
Store   = require './models/store'

# Top Level View
AppView = require './views/appView'

store   = new Store(new PeopleService(superagent, 'http://localhost:8000'))
appView = new AppView(store)

appView.render()

