{$}             = require 'atom'

TabBarView      = require atom.packages.resolvePackagePath('tabs') + '/lib/tab-bar-view'
SublimeTabView  = require './sublime-tab-view'

module.exports =
class SublimeTabBarView extends TabBarView

  initialize: (@pane) ->
    super(@pane)
    @openPermanent ?= []
    @subscribe $(window), 'window:open-path', (event, {pathToOpen}) =>
      path = atom.project?.relativize(pathToOpen) ? pathToOpen
      @openPermanent.push pathToOpen unless pathToOpen in @openPermanent

  addTabForItem: (item, index) ->
    for tab in @getTabs()
      @closeTab(tab) if tab.is('.temp')

    @insertTabAtIndex(new SublimeTabView(item, @pane, @openPermanent), index)
    @updateActiveTab()
