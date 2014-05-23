{WorkspaceView} = require 'atom'
SublimeTabs = require '../lib/sublime-tabs'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SublimeTabs", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('sublime-tabs')

  describe "when the sublime-tabs:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.sublime-tabs')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'sublime-tabs:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.sublime-tabs')).toExist()
        atom.workspaceView.trigger 'sublime-tabs:toggle'
        expect(atom.workspaceView.find('.sublime-tabs')).not.toExist()
