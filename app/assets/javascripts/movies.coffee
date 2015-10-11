# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.ajax-form').on 'change', ->
    console.log('hoge')
    $.ajax
      url: $(@).data('url')
      dataType: 'json'
      method: 'PATCH'
      data: $(@).find('form').serialize()
    .done (json) ->
      toastr.info('更新しました')
    .fail ->
      toastr.error('更新に失敗しました')
      
