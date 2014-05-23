SublimeTabBarView = require './sublime-tab-bar-view'
_ = require 'underscore-plus'

module.exports =
  configDefaults:
    showIcons: true

  activate: ->
    @paneSubscription = atom.workspaceView.eachPaneView (paneView) =>
      tabBarView = new SublimeTabBarView(paneView)
      @tabBarViews ?= []
      @tabBarViews.push(tabBarView)
      onPaneViewRemoved = (event, removedPaneView) =>
        return unless paneView is removedPaneView
        _.remove(@tabBarViews, tabBarView)
        atom.workspaceView.off('pane:removed', onPaneViewRemoved)
      atom.workspaceView.on('pane:removed', onPaneViewRemoved)
      tabBarView

  deactivate: ->
    @paneSubscription?.off()
    tabBarView.remove() for tabBarView in @tabBarViews ? []
