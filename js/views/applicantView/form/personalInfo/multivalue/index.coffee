component = require '../../../../../utils/component'
style = require './style'
{extend, remove} = require '../../../../../utils'

module.exports = component 'personalInfoMultivalue', ({dom, events, returnObject}, input) ->
  {E, setStyle, append, destroy} = dom
  {onEvent} = events

  changeListeners = []
  data = []
  items = []

  setStyle input, style.input

  view = E style.view,
    itemsPlaceholder = E()
    input
    add = E style.add

  setViewHeight = ->
    setStyle view, height: (items.length + 1) * 30

  addItem = (text) ->
    newItem = E style.item,
      E extend {englishText: text}, style.itemText
      removeItem = E style.remove
    append itemsPlaceholder, newItem
    data.push text
    items.push newItem
    setViewHeight()
    setStyle input, value: ''
    onEvent removeItem, 'click', ->
      destroy newItem
      data.splice items.indexOf(newItem), 1
      remove items, newItem
      setViewHeight()
      changeListeners.forEach (x) -> x(false)

  onEvent add, 'click', ->
    unless changeListeners.every((x) -> x(true) isnt false)
      return
    addItem input.value()

  returnObject
    input: input
    onChange: (listener) -> changeListeners.push listener
    value: -> data
    add: addItem


  view