path = require 'path'
shell = require 'shell'

_ = require 'underscore-plus'
{$, BufferedProcess} = require 'atom'
fs = require 'fs-plus'
TreeView = require atom.packages.resolvePackagePath('tree-view') + '/lib/tree-view'

AddDialog = null  # Defer requiring until actually needed
MoveDialog = null # Defer requiring until actually needed
CopyDialog = null # Defer requiring until actually needed

Directory = require atom.packages.resolvePackagePath('tree-view') + '/lib/directory'
DirectoryView = require atom.packages.resolvePackagePath('tree-view') + '/lib/directory-view'
File = require atom.packages.resolvePackagePath('tree-view') + '/lib/file'
FileView = require atom.packages.resolvePackagePath('tree-view') + '/lib/file-view'
LocalStorage = window.localStorage

module.exports =
class SublimeTreeView extends TreeView
  initialize: (state) ->
    super(state)

    @on 'dblclick', '.entry', (e) ->
      return if e.shiftKey || e.metaKey
      atom.workspaceView.find('.tab-bar .tab.active').removeClass('temp')

  entryDblClicked: (e) ->
    @selectedEntry = $(e.currentTarget).view()
    @openSelectedEntry(false, true)
