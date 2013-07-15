###
FieldExpander jQuery Plugin v1.0 - Auto grows and shrinks text fields in forms.
Release: 15/07/2013
Author: Tom Simnett <tom@initforthe.com>

http://github.com/initforthe/jquery-field-expander

Licensed under the MIT licence: opensource.org/licenses/MIT
###

(($, window, document) ->
  $this = undefined

  _settings =
    fields: 'input[type=text],input[type=tel],input[type=email]'
    
  methods =
    init: (options) ->
      $this = $(@)
      $.extend _settings, (options or {})
      
      $this.each (index, el) ->
        $(el).find(_settings.fields).each (i, field) ->
          $(field).data('size', $(field).attr('size'))

        _internals.setListener(el)
 
      return $this

    destroy: ->
      $this.each (index, el) ->
        _internals.unsetListener(el)
      return $this

  _internals =
    setListener: (which) ->
      $(which).on 'keypress keyup', _settings.fields, _internals.setFieldSize

    unsetListener: (which) ->
      $(which).off 'keypress keyup', _settings.fields, _internals.setFieldSize

    setFieldSize: (event) ->
      which = $(event.target)

      len = which.val().length

      if len > which.data('size')
        which.attr('size', len+1)
      else which.attr('size', which.data('size'))

  $.fn.fieldExpander = (method) ->
    if methods[method]
      methods[method].apply this, Array::slice.call(arguments, 1)
    else if typeof method is "object" or not method
      methods.init.apply this, arguments
    else
      $.error "Method " + method + " does not exist on jquery.fieldExpander"
) jQuery, window, document
