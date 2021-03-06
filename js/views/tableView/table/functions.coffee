style = require './style'
{collection, compare} = require '../../../utils'

exports.create = ({headers, properties, handlers, variables, components, dom, events}) ->
  {E, destroy, append, setStyle, show, hide, empty} = dom
  {onEvent} = events




  functions =
    update: (doNotReset) ->
      if variables.descriptors
        hide components.noData
        show components.yesData
        if variables.sort
          variables.descriptors = variables.descriptors.sort ({entity: a}, {entity: b}) ->
            header = variables.sort.header
            if variables.sort.direction is 'up'
              [first, second] = [a, b]
            else
              [first, second] = [b, a]
            if header.getValue
              firstValue = header.getValue first
              secondValue = header.getValue second
            else
              firstValue = first[header.key]
              secondValue = second[header.key]
            result = compare firstValue, secondValue
            if result is 0 && variables.entityId
              compare first[variables.entityId], second[variables.entityId]
            else
              result
      descriptors = variables.descriptors || []
      variables.selectionMode = descriptors.some ({selected}) -> selected
      descriptors.forEach (descriptor, index) ->
        descriptor.index = index

      # functions.handleRows descriptors
      itemsInPage = +components.paginationSelect.value()
      pageCount = Math.ceil descriptors.length / itemsInPage
      unless doNotReset
        variables.currentPage = 1
      do updatePage = ->
        start = Math.max 1, variables.currentPage - 2
        end = Math.min pageCount, start + 4
        start = Math.max 1, end - 4
        empty components.paginationNumbers
        append components.paginationNumbers, [
          first = E style.paginationNumberGreen, '<<'
          prev = E style.paginationNumberGreen, '<'
          [start .. end].map (page) ->
            number = E (if page == variables.currentPage then style.paginationNumberCurrent else style.paginationNumber), page
            onEvent number, 'click', ->
              variables.currentPage = page
              updatePage()
            number
          next = E style.paginationNumberGreen, '>'
          last = E style.paginationNumberGreen, '>>'
        ]
        onEvent first, 'click', ->
          variables.currentPage = 1
          updatePage()
        onEvent prev, 'click', ->
          variables.currentPage--
          if variables.currentPage < 1
            variables.currentPage = 1
          updatePage()
        onEvent next, 'click', ->
          variables.currentPage++
          if variables.currentPage > pageCount
            variables.currentPage = pageCount
          updatePage()
        onEvent last, 'click', ->
          variables.currentPage = pageCount
          updatePage()
        functions.handleRows descriptors.slice itemsInPage * (variables.currentPage - 1), itemsInPage * variables.currentPage

      handlers.update descriptors

    setData: (entities) ->
      unless variables.descriptors
        variables.descriptors = entities.map (entity) -> {entity}
      else
        variables.descriptors = entities.map (entity) ->
          returnValue = undefined
          shouldReturn = variables.descriptors.some (x) ->
            if functions.isEqual entity, x.entity
              returnValue = x
              true
          if shouldReturn
            returnValue.entity = entity
            returnValue
          else
            {entity}
      functions.update()

    setSelectedRows: (callback) ->
      variables.descriptors.forEach (descriptor) -> descriptor.selected = false
      callback(variables.descriptors).forEach (descriptor) -> descriptor.selected = true
      functions.update true

    setSort: (header) ->
      headers.forEach ({arrowUp, arrowDown}) ->
        if arrowUp
          setStyle arrowUp, style.arrowUp
        if arrowDown
          setStyle arrowDown, style.arrowDown
      sort = variables.sort
      if sort?.header is header && sort.direction is 'up'
        setStyle header.arrowDown, style.arrowActive
        sort.direction = 'down'
      else
        setStyle header.arrowUp, style.arrowActive
        variables.sort = header: header, direction: 'up'
      functions.update()

    styleTd: (header, {entity}, td, row) ->
      if header.key
        setStyle td, text: entity[header.key]
      else if header.englishKey
        setStyle td, englishText: entity[header.englishKey]
      else if header.getValue
        setStyle td, text: header.getValue entity
      if header.styleTd
        header.styleTd entity, td, row.offs, row
      td

    setupRow: (row, descriptor) ->
      row.off = ->
        row.offs.forEach (x) -> x()
        row.offs = []
      do setDefaultStyle = ->
        unless functions.styleRow
          setStyle row.tr, if descriptor.index % 2
            style.row
          else
            style.rowOdd
        else
          functions.styleRow descriptor.entity, row.tr
      if properties.multiSelect
        setStyle row.checkbox, style.checkbox
        if descriptor.selected
          setStyle row.tr, style.rowSelected
          setStyle row.checkbox, style.checkboxSelected
        row.offs.push onEvent row.checkboxTd, 'click', ->
          descriptor.selected = !descriptor.selected
          functions.update true
      if handlers.select && not descriptor.unselectable
        unless descriptor.selected
          row.offs.push onEvent row.tr, 'mousemove', ->
            setStyle row.tr, style.rowHover
          row.offs.push onEvent row.tr, 'mouseout', ->
            setDefaultStyle()
        row.tds.forEach (td) ->
          setStyle td, cursor: 'pointer'
        notClickableTds = row.tds.filter (_, i) -> headers[i].notClickable
        if properties.multiSelect
          notClickableTds.push row.checkboxTd
        row.offs.push onEvent row.tr, 'click', notClickableTds, ->
          handlers.select descriptor.entity
      row

    addRow: (descriptor, i) ->
      row = offs: []
      append components.body, row.tr = E 'tr', null,
        if properties.multiSelect
          row.checkboxTd = E 'td', cursor: 'pointer',
            row.checkbox = E style.checkbox
        row.tds = headers.map (header) ->
          functions.styleTd header, descriptor, E('td', style.td), row, i
      functions.setupRow row, descriptor

    changeRow: (descriptor, row, i) ->
      row.off()
      row.tds.forEach (td, index) ->
        functions.styleTd headers[index], descriptor, td, row, i
      functions.setupRow row, descriptor

    removeRow: (row) ->
      row.off()
      destroy row.tr

  functions.handleRows = collection functions.addRow, functions.removeRow, functions.changeRow
  functions