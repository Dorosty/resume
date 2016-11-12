{extend} = require '../../../utils'

exports.sidebar =
  backgroundColor: '#2b2e33'
  position: 'absolute'
  top: 0
  right: 0
  width: 200

exports.profile =
  overflow: 'hidden'
  borderRadius: 100
  width: 150
  height: 150
  marginTop: 20
  marginRight: 20
  border: '5px solid #1c1e21'
  position: 'relative'

exports.profileImg =
  position: 'absolute'

exports.name =
  fontSize: 14
  textAlign: 'center'
  color: 'white'
  marginTop: 30

exports.title =
  fontSize: 14
  textAlign: 'center'
  color: '#505d63'
  marginTop: 10

icon =
  color: 'white'
  float: 'right'
  cursor: 'pointer'
  margin: 20
  fontSize: 20

exports.logout = extend {}, icon,
  class: 'fa fa-power-off'
  marginRight: 30

exports.settings = extend {}, icon,
  class: 'fa fa-sliders'

exports.notifications = extend {}, icon,
  class: 'fa fa-bell-o'

exports.divider =
  marginTop: 80
  height: 2
  backgroundColor: '#1c1e21'

exports.links =
  marginTop: 20

exports.link =
  cursor: 'pointer'
  height: 65
  lineHeight: 65
  textAlign: 'center'
  color: 'white'

exports.linkActive = extend {}, exports.link,
  backgroundColor: '#449e73'