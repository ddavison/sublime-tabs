{$} = require 'atom'
_ = require 'underscore-plus'
path = require 'path'
TabView = require './tabs/lib/tab-view'

module.exports =
class SublimeTabView extends TabView

  initialize: (@item, @pane) ->
    super(@item, @pane)
    @addClass('temp')

  updateModifiedStatus: ->
    if @item.isModified?()
      console.log "modified: #{@item.isModified?()} : #{@is('.temp')}"
      @addClass('modified') unless @isModified
      @removeClass('temp') if @is('.temp')
      @isModified = true
    else
      @removeClass('modified') if @isModified
      @isModified = false
