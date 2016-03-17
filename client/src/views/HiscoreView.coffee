{PropTypes: {arrayOf, shape, object, string, number}} = React = require 'react'
Radium = require 'radium'
{connect} = require 'react-redux'
{bindActionCreators} = require 'redux'
{add, always, dissoc, isNil, map, merge, none} = require 'ramda' #auto_require:ramda
{div, img, i, span} = React.DOM
{BASE_URL_DATA_API} = require 'config'

yun = require 'yun-ui-kit'
{build} = yun.react
{Link} = yun.ThemeMaterialDesign

s = require './style/HiscoreView.style'
{workoutsByUser, sortedTodos} = require '../base/selectors'

HiscoreView = Radium React.createClass
	displayName: 'HiscoreView'

	propTypes:
		users: arrayOf shape
			width: number
			name: string
			email: string
			imageUrl: string
			steps: number
			crunches: number
			pushups: number
			pullups: number
		users2: arrayOf object
		order: string


	render: ->
		{users} = @props
		if !users
			return div {}, 'No users loaded'

		div {},
			@renderTopbar()
			@renderContent()

	renderContent: ->
		div {style: s.contentBox},
			div {style: s.contentSpacer}
			map @renderUser, @props.users
			# @renderAdd()

	renderTopbar: ->
		{order} = @props
		div {style: s.topbar},
			# build Link, {to: always({page: 'profile'}), style: {textDecoration: 'none'}},
			# 	i {className: 'material-icons', style: s.menuIcon}, 'menu'
			build Link,
				{to: dissoc('order'),
				style: if isNil order then s.selectedItem else s.item}, 'Total'
			build Link,
				{to: {order: 'steps'},
				style: if order == 'steps' then s.selectedItem else s.item}, 'Steps'
			build Link,
				{to: {order: 'crunches'},
				style: if order == 'crunches' then s.selectedItem else s.item}, 'Crunches'
			build Link,
				{to: {order: 'pushups'}, 
				style: if order == 'pushups' then s.selectedItem else s.item}, 'Pushups'
			build Link,
				{to: {order: 'pullups'},
				style: if order == 'pullups' then s.selectedItem else s.item}, 'Pullups'

	renderUser: (user) ->
		width = "#{user.width / 100 * 80}vw"
		{steps, crunches, pushups, pullups} = user
		steps_ = steps / 100
		total = steps_ + crunches + pushups + pullups
		stepsText = if steps then Math.round(steps / 1000) + 'k' else '0'
		crunchesText = crunches
		pushupsText = pushups
		pullupsText = pullups
		div {key: user.email, style: s.userBox},
			div {style: merge(s.user, {width})},
				img {style: s.pic, src: "#{BASE_URL_DATA_API}#{user.imageUrl}"}
				div {style: s.barBox},
					if user.width > 50
						[
							div {key: 'steps', style: merge(s.steps, {width: "#{steps_ / total * 100}%"})}, stepsText
							div {key: 'crunches', style: merge(s.crunches, {width: "#{crunches / total * 100}%"})}, crunchesText
							div {key: 'pushups', style: merge(s.pushups, {width: "#{pushups / total * 100}%"})}, pushupsText
							div {key: 'pullups', style: merge(s.pullups, {width: "#{pullups / total * 100}%"})}, pullupsText
						]
					else
						[
							div {key: 'steps', style: merge(s.steps, {width: "#{steps_ / total * 100}%"})}
							div {key: 'crunches', style: merge(s.crunches, {width: "#{crunches / total * 100}%"})}
							div {key: 'pushups', style: merge(s.pushups, {width: "#{pushups / total * 100}%"})}
							div {key: 'pullups', style: merge(s.pullups, {width: "#{pullups / total * 100}%"})}
						]
			if user.width <= 50
				div {style: s.extraLabels},
					"#{stepsText} / #{crunchesText} / #{pushupsText} / #{pullupsText}"
					# span {}, stepsText
					# span {}, crunchesText
					# span {}, pushupsText
					# span {}, pullupsText
			div {style: s.name}, user.name

	renderAdd: ->
		build Link, {to: always({page: 'daily'})},
			div {style: s.add},
				i {className: 'material-icons', style: s.addIcon}, 'add'


# stateToProps = (state) -> {todos: state.todos}
stateToProps = (state) ->
	order: state.url.query.order
	users: workoutsByUser(state)

# dispatchToProps = (dispatch) ->
# 	{actions: bindActionCreators(actions, dispatch)}

HiscoreView_default = connect(stateToProps)(HiscoreView)

module.exports = {HiscoreView_default}
