React = require 'react'
ReactDOM = require 'react-dom'
AppView = React.createFactory require('./views/AppView')
Provider = React.createFactory require('react-redux').Provider
{compose, forEach, identity, keys} = require 'ramda' #auto_require:ramda

{createStore, applyMiddleware} = require 'redux'
thunkMiddleware = require('redux-thunk').default
rootReducer = require './reducers'

# pollyfill Promise and fetch
require('es6-promise').polyfill()
require('isomorphic-fetch')

FastClick = require 'fastclick'
FastClick.attach(document.body)

{forEach, keys} = R = require 'ramda'

install = (o, target) ->
	addKey = (k) -> target[k] = o[k]
	forEach addKey, keys o
	
install {R}, window
install R, window

ramdaExtras = require 'ramda-extras'
install {ramdaExtras}, window
install ramdaExtras, window


# devTools = -> 
# 	if window.devToolsExtension then window.devToolsExtension() else identity
# finalCreateStore = compose(devTools())(createStore)

enhancer = applyMiddleware thunkMiddleware

configureStore = (initialState) ->
	# store = finalCreateStore rootReducer, initialState
	enhancer = compose applyMiddleware(thunkMiddleware),
		if window.devToolsExtension then window.devToolsExtension() else identity
	store = createStore rootReducer, initialState, enhancer

	if module.hot
		# Enable Webpack hot module replacement for reducers
		module.hot.accept './reducers', () ->
			nextReducer = require('./reducers')
			store.replaceReducer nextReducer

	return store


store = configureStore()

ReactDOM.render(Provider({store}, AppView()), document.getElementById('root'))
