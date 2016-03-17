{F, add, merge, min} = require 'ramda' #auto_require:ramda

topbar =
	flexDirection: 'row'
	fontSize: 12
	color: 'rgba(255,255,255,0.85)'
	background: '#210303'
	# boxShadow: '0px 2px 3px 2px rgba(0,0,0,0.50)'
	alignItems: 'center'
	justifyContent: 'space-around'
	padding: '0px 5px'
	'@media (min-width: 350px)':
		fontSize: 14
	position: 'fixed'
	zIndex: 9999
	width: '100vw'
	height: 60

contentBox =
	overflowY: 'scroll'
	WebkitOverflowScrolling: 'touch'
	height: '100vh'

contentSpacer =
	height: 60

item =
	padding: '5px 1vw'
	border: '1px solid rgba(255,255,255,0)'
	'@media (min-width: 350px)':
		padding: '5px 2vw'

selectedItem =
	padding: '5px 1vw'
	border: '1px solid rgba(255,255,255,0.81)'
	borderRadius: 4
	'@media (min-width: 350px)':
		padding: '5px 2vw'

userBox =
	flexDirection: 'row'
	# width: '100vw'
	justifyContent: 'space-between'
	# height: 70

user =
	flexDirection: 'row'
	backgroundImage: 'linear-gradient(-180deg, rgba(205,156,156,0.20) 0%, rgba(129,88,88,0.31) 100%)'
	boxShadow: '2px 2px 6px 0px rgba(0,0,0,0.14), inset 0px 1px 1px 0px rgba(255,255,255,0.31)'
	borderRadius: 9
	height: 50
	margin: '5px 10px'
	# justifyContent: 'center'
	alignItems: 'center'
	padding: '0 10px'
	flexDirection: 'row'

pic =
	borderRadius: 999
	height: 40
	width: 40
	boxShadow: '0px 2px 2px 0px rgba(0,0,0,0.68)'
	position: 'absolute'
	zIndex: 999
	top: 5

name =
	justifyContent: 'center'
	paddingRight: 15
	fontSize: 14
	color: 'rgba(255,255,255,0.50)'

barBox =
	width: '100%'
	flexDirection: 'row'
	paddingLeft: 30

stuff = 
	height: 30
	justifyContent: 'center'
	alignItems: 'center'
	boxShadow: '2px 2px 6px 0px rgba(0,0,0,0.14), inset 0px 1px 1px 0px rgba(255,255,255,0.31)'
	color: '#3C3C3C'
	fontSize: 12
	textShadow: '0px 1px 1px rgba(255,255,255,0.50)'
	'@media (min-width: 350px)':
		fontSize: 14

	# textOverflow: 'ellipsis' too many dots to use ellipsis here
	# overflow: 'hidden'

steps = merge stuff,
	backgroundImage: 'linear-gradient(-180deg, #DBDB23 0%, #DCBD2F 100%)'

crunches = merge stuff,
	backgroundImage: 'linear-gradient(-180deg, #DB8B23 0%, #DC782F 99%)'

pushups = merge stuff,
	backgroundImage: 'linear-gradient(-180deg, #DB6223 0%, #DC4F2F 97%)'

pullups = merge stuff,
	backgroundImage: 'linear-gradient(-180deg, #7DC849 0%, #37A32B 96%)'
	borderTopRightRadius: 5
	borderBottomRightRadius: 5

extraLabels =
	flexDirection: 'row'
	alignItems: 'center'
	paddingRight: 15
	fontSize: 12
	color: 'rgba(255,255,255,0.50)'
	justifyContent: 'space-between'

add =
	background: '#F5F5F5'
	boxShadow: '0px 3px 6px 0px rgba(0,0,0,0.40), inset 0px 1px 2px 0px #FFFFFF'
	color: '#34393E'
	width: 50
	height: 50
	position: 'fixed'
	bottom: 20
	right: 20
	justifyContent: 'center'
	alignItems: 'center'
	borderRadius: 999

addIcon =
	fontSize: 35

module.exports = {user, pic, steps, crunches, pushups, pullups, barBox,
userBox, name, topbar, selectedItem, item, add, addIcon, extraLabels,
contentBox, contentSpacer}

