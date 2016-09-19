mock = require './mockService'
log = require('./log').service
Q = require '../q'
state = require './state'
{eraseCookie} = require './cookies'

handle = (isGet) -> (url, params = {}) ->

  if mock[url]
    return mock[url] params

  url = "/webApi/#{url}?rand=#{Math.random()}&"

  if isGet
    url += Object.keys(params).map((param) -> "#{param}=#{params[param]}").join '&'
  Q.promise (resolve, reject) ->
    xhr = new XMLHttpRequest()
    xhr.onreadystatechange = ->
      if xhr.readyState is 4
        if xhr.status is 200
          resolve JSON.parse xhr.responseText
        else
          reject xhr.responseText
    methodType = if isGet then 'GET' else 'POST'
    xhr.open methodType, url, true
    if isGet
      xhr.send()
    else
      xhr.setRequestHeader 'Content-Type', 'application/json'
      xhr.send JSON.stringify params

get = handle true
post = handle false

exports.instance = (thisComponent) ->
  exports = {}

  [
  ]
  .forEach (x) ->
    exports[x] = (params) ->
      l = log.get thisComponent, x, params
      l()
      get x, params
      .then (data) ->
        l data
        data

  [
    'login'
    'logout'
  ]
  .forEach (x) ->
    exports[x] = (params) ->
      l = log.post thisComponent, x, params
      l()
      post x, params
      .then (data) ->
        l data
        data
  
  exports