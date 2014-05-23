BrowserWindow = null # Defer require until actually used
RendererIpc = require('ipc')

{$} = require 'atom'
_ = require 'underscore-plus'
TabBarView = require './tabs/lib/tab-bar-view'
SublimeTabView = require './sublime-tab-view'

module.exports =
class SublimeTabBarView extends TabBarView

  initialize: (@pane) ->
    super(@pane)

  addTabForItem: (item, index) ->
    for tab in @getTabs()
      @closeTab(tab) if tab.is('.temp')

    tab.updateTitle() for tab in @getTabs()
    @insertTabAtIndex(new SublimeTabView(item, @pane), index)
