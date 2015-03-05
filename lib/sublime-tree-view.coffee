{$} = require 'atom'

TreeView      = require atom.packages.resolvePackagePath('tree-view') + '/lib/tree-view'
DirectoryView = require atom.packages.resolvePackagePath('tree-view') + '/lib/directory-view'
FileView      = require atom.packages.resolvePackagePath('tree-view') + '/lib/file-view'

module.exports =
class SublimeTreeView extends TreeView
  initialize: (state) ->
    super(state)

    atom.commands.add '.tree-view',
      'tree-view:expand-directory-or-preview-file', => @expandDirOrPreview()

    @on 'dblclick', '.entry', (e) ->
      return if e.shiftKey || e.metaKey || e.altKey
      atom.workspaceView.find('.tab-bar .tab.active').removeClass('temp')
      false

  entryDblClicked: (e) ->
    @selectedEntry = $(e.currentTarget).view()
    @openSelectedEntry(false, true)

  expandDirOrPreview: () ->
    selectedEntry = @selectedEntry()
    if selectedEntry instanceof DirectoryView
      selectedEntry.expand(false)
    else if selectedEntry instanceof FileView
      atom.workspace.open(selectedEntry.getPath(), activatePane:false)
