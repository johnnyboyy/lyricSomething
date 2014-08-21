addErrorMessage = undefined
addErrorStyling = undefined
clearFields = undefined
clearMessages = undefined
errorPostMessage = undefined
fieldIsEmpty = undefined
fields = undefined
resetStyle = undefined
succesfulPostMessage = undefined
validFields = undefined
validUrl = undefined

fields = $(".form-control")
validFields = [
  false
  false
  false
]
$ ->
  $("#post-button").on "click", ->
    fields = $(".form-control")
    clearMessages()
    $.each fields, (key, field) ->
      resetStyle field
      if fieldIsEmpty field
        validFields[key] = false
        addErrorStyling field
        addErrorMessage field
      else
        validFields[key] = true
      return

    if validFields[0] + validFields[1] + validFields[2] is 3
      if validUrl(fields[2].value)
        succesfulPostMessage()
        setTimeout (->
          clearFields()
          return
        ), 500
      else
        badUrlError()
    else
      errorPostMessage()
    return

  return

clearFields = ->
  $.each fields, (key, field) ->
    field.value = ""
    return

  return

clearMessages = ->
  $("#error-messages").html ""
  return

resetStyle = (field) ->
  field.style.border = ""
  return

addErrorStyling = (field) ->
  field.style.border = "2pt solid red"
  return

fieldIsEmpty = (field) ->
  true  if field.value is ""

addErrorMessage = (field) ->
  $("#error-messages").append "<p class=\"error\">" + field.id.substr(5) + " can't be blank. </p>"

  return

succesfulPostMessage = ->
  $("#alerts").append "<p class=\"alert alert-success\">Succesful Post!!!</p>"
  fadeAlert()
  return

errorPostMessage = ->
  $("#alerts").append "<p class=\"alert alert-danger\">Error! The post isn't valid!!!</p>"
  fadeAlert()
  return

validUrl = (str) ->
  exp = /(www\.)?[-a-zA-Z0-9:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/
  urlRegex = new RegExp(exp)
  if urlRegex.test str
    return true

badUrlError = ->
  addErrorStyling(fields[2])
  $('#error-messages').append("<p class=\"error\"> The Url is not valid. It should look like: 'www.exapmle.com/whatever' </p>")

fadeAlert = ->
  $(".alert").fadeOut 2000, ->
    $(this).remove()
    return