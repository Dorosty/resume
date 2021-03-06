{extend} = require '../../utils'

exports.option =
  float: 'right'
  border: '1px solid #ddd'
  cursor: 'pointer'
  padding: '0 10px'
  marginLeft: -1
  fontSize: 12
  height: 30
  lineHeight: 30
  transition: '0.2s'
  backgroundColor: 'white'
  color: '#777'

exports.leftOption = extend {}, exports.option,
  borderRadius: '3px 0 0 3px'

exports.rightOption = extend {}, exports.option,
  borderRadius: '0 3px 3px 0'

exports.optionActive =
  backgroundColor: '#449e73'
  color: 'white'