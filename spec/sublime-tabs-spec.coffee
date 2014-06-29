{$, WorkspaceView, View}  = require 'atom'
_                         = require 'underscore-plus'
path                      = require 'path'
SublimeTabBarView         = require '../lib/sublime-tab-bar-view'
SublimeTabView            = require '../lib/sublime-tab-view'

describe "Sublime Tabs Package", ->
  beforeEach: ->
    atom.workspaceView = new WorkspaceView

    waitsForPromise ->
      atom.workspace.open('sample.coffee')

    waitsForPromise ->
      atom.packages.activatePackage('sublime-tabs')

describe 'SublimeTabBarView', ->
  [item1, item2, editor1, pane, tabBar] = []

  class TestView extends View
    @deserialize: ({title, longTitle, iconName}) -> new TestView(title, longTitle, iconName)
    @content: (title) -> @div title
    initialize: (@title, @longTitle, @iconName) ->
    getTitle: -> @title
    getLongTitle: -> @longTitle
    getIconName: -> @iconName
    serialize: -> { deserializer: 'TestView', @title, @longTitle, @iconName }

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model
    atom.deserializers.add(TestView)
    item1 = new TestView('Item 1', undefined, 'squirrel')
    item2 = new TestView('Item 2')

    waitsForPromise ->
      atom.workspace.open('sample.coffee')

    runs ->
      editor1 = atom.workspace.getActiveEditor()
      pane = atom.workspaceView.getActivePaneView()
      pane.addItem(item1, 0)
      pane.addItem(item2, 2)
      pane.activateItem(item2)
      tabBar = new SublimeTabBarView(pane)

  afterEach ->
    atom.deserializers.remove(TestView)

  describe 'Temporary Tabs', ->
    it 'adds a temp class when opening a file', ->
      editor2 = null

      waitsForPromise ->
        atom.project.open('sample.txt').then (o) -> editor2 = o

      runs ->
        pane.activateItem(editor2)
        expect(tabBar.tabForItem(editor2)).toHaveClass 'temp'
