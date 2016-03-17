React = require 'react'
{div, link} = React.DOM
Radium = require 'radium'
StyleRoot = React.createFactory Radium.StyleRoot
Style = React.createFactory Radium.Style
yun = require 'yun-ui-kit'
console.log 'yun', yun
{build} = yun.react
{ThemeMaterialDesign} = yun

{BodyView_default} = require './BodyView'

reset =
	a:
		color: 'inherit'
		textDecoration: 'none'
	html:
		backgroundImage: 'linear-gradient(-180deg, #200303 0%, #8E1313 100%)'
		
AppView = React.createClass
	displayName: 'AppView'

	render: ->
		StyleRoot {},
			Style {rules: reset}
			Style {rules: ThemeMaterialDesign.GlobalRules}
			link {href:'https://fonts.googleapis.com/icon?family=Material+Icons', rel:'stylesheet'}
			build BodyView_default

module.exports = AppView
