{PropTypes: {object, func, shape}} = React = require 'react'
{div, h1} = React.DOM
{bindActionCreators} = require 'redux'
{connect} = require 'react-redux'
# fbjs: follow discussion here: https://github.com/larrymyers/react-mini-router/issues/46
EventListener = require 'fbjs/lib/EventListener'
yun = require 'yun-ui-kit'
{build} = yun.react
{Link} = yun.ThemeMaterialDesign
{HiscoreView_default} = require './HiscoreView'
actions = require '../actions'
{always, isNil} = require 'ramda' #auto_require:ramda
s = require './style/BodyView.style'

BodyView = React.createClass
	displayName: 'BodyView'

	propTypes:
		url: object
		actions: shape
			setQuery: func
			workoutAll: func
			userAll: func

	componentWillMount: ->
		query = yun.url.getQuery()
		@props.actions.setQuery query
		@props.actions.workoutAll()
		@props.actions.userAll()

		EventListener.listen window, 'popstate', =>
			query = yun.url.getQuery()
			@props.actions.setQuery query
			return true

	componentWillReceiveProps: (nextProps) ->
		if isNil nextProps.url.query.page
			yun.url.navigate {page: 'hiscore'}

	render: ->
		{page} = @props.url.query
		div {style: s.body},
			switch page
				when 'todo'
					build MainSection_default
				when 'hiscore'
					build HiscoreView_default
				when null || undefined then @renderLoading()
				else @renderNotFound()

	renderLoading: ->
		div {},
			h1 {}, 'Laddar...'

	renderNotFound: ->
		div {},
			h1 {}, '404 - Sidan finns inte'
			build Link, {to: always({})}, 'Gå till startsidan'


stateToProps = (state) -> {url: state.url}
dispatchToProps = (dispatch) ->
	{actions: bindActionCreators(actions, dispatch)}

BodyView_default = connect(stateToProps, dispatchToProps)(BodyView)

module.exports = {BodyView, BodyView_default}
