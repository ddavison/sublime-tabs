{$}             = require 'atom'

TabBarView      = require atom.packages.resolvePackagePath('tabs') + '/lib/tab-bar-view'
SublimeTabView  = require './sublime-tab-view'

module.exports =
class SublimeTabBarView extends TabBarView

  initialize: (@pane) ->

    # During initialization we do not add temporary tabs. This prevents bugs
    # associated with serialization.
    @considerTemp = false

    super(@pane)
    @openPermanent ?= []
    @subscribe $(window), 'window:open-path', (event, {pathToOpen}) =>
      path = atom.project?.relativize(pathToOpen) ? pathToOpen
      @openPermanent.push pathToOpen unless pathToOpen in @openPermanent

    @subscribe atom.workspaceView, 'core:save', ->
      tab = atom.workspaceView.find('.tab.active')
      tab.removeClass('temp') if tab.is('.temp')

    # Tabs added manually by the user should consider temporary status.
    @considerTemp = true

    @on 'dblclick', '.tab', ({target}) ->
      tab = $(target).closest('.tab').view()
      tab.removeClass('temp') if tab.is('.temp')
      false

  addTabForItem: (item, index) ->
    for tab in @getTabs()
      @closeTab(tab) if tab.is('.temp')

    tabView = new SublimeTabView(item, @pane, @openPermanent, @considerTemp)
    @insertTabAtIndex(tabView, index)
    @updateActiveTab()
