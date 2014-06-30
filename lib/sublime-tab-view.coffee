_       = require 'underscore-plus'
path    = require 'path'
{$}     = require 'atom'
TabView = require atom.packages.resolvePackagePath('tabs') + '/lib/tab-view'

module.exports =
class SublimeTabView extends TabView

  initialize: (@item, @pane, openPermanent=[], considerTemporary) ->
    super(@item, @pane)
    return unless considerTemporary

    console.log @item.constructor.name
    if @item.constructor.name is 'Editor' ||
       @item.constructor.name is 'ImageEditor'
      if @item.getPath() in openPermanent
        _.remove(openPermanent, @item.getPath())
      else
        @addClass('temp')

    atom.workspaceView.command 'sublime-tabs:keep-tab', => @keepTab()

  updateModifiedStatus: ->
    super()
    @removeClass('temp') if @is('.temp') and @item.isModified?()

  keepTab: ->
    @removeClass('temp') if @is('.temp')
