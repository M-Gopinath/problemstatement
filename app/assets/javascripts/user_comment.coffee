# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '.submit-comment-btn', (e) ->
  e.preventDefault()
  e.stopPropagation()
  $.ajax
    url: '/user_comments'
    type: 'POST'
    dataType: 'script'
    data: $('#new_user_comment').serialize()
  return