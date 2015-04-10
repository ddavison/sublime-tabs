{$, View} = require 'atom'
_ = require 'underscore-plus'
path = require 'path'

module.exports =
class TabView extends View
  @content: ->
    @li class: 'tab sortable', =>
      @div class: 'title', outlet: 'title'
      @div class: 'close-icon'

  initialize: (@item, @pane) ->
    @item.on? 'title-changed', =>
      @updateTitle()
      @updateTooltip()
      @updateDataAttributes()

    @item.on? 'icon-changed', =>
      @updateIcon()

    @item.on? 'modified-status-changed', =>
      @updateModifiedStatus()

    @subscribe atom.config.observe 'tabs.showIcons', => @updateIconVisibility()

    @updateTitle()
    @updateIcon()
    @updateModifiedStatus()
    @updateTooltip()
    @updateDataAttributes()

  updateTooltip: ->
    @destroyTooltip()

    if itemPath = @item.getPath?()
      @setTooltip
        title: _.escape(itemPath)
        delay:
          show: 2000
          hide: 100
        placement: 'bottom'

  beforeRemove: ->
    @destroyTooltip()

  updateTitle: ->
    return if @updatingTitle
    @updatingTitle = true

    title = @item.getTitle()
    useLongTitle = false
    for tab in @getSiblingTabs()
      if tab.item.getTitle() is title
        tab.updateTitle()
        useLongTitle = true
    title = @item.getLongTitle?() ? title if useLongTitle

    @title.text(title)
    @updatingTitle = false

  updateDataAttributes: ->
     return if @updatingDataAttributes
     @updatingDataAttributes = true

     if @item.getPath?
       itemPath = @item.getPath()
       name = path.basename(itemPath)
       @title.attr 'data-path', itemPath
       @title.attr 'data-name', name

     @updatingDataAttributes = false

  updateIcon: ->
    if @iconName
      @title.removeClass "icon icon-#{@iconName}"

    if @iconName = @item.getIconName?()
      @title.addClass "icon icon-#{@iconName}"

  getSiblingTabs: ->
    @siblings('.tab').views()

  updateIconVisibility: ->
    if atom.config.get "tabs.showIcons"
      @title.removeClass("hide-icon")
    else
      @title.addClass("hide-icon")

  updateModifiedStatus: ->
    if @item.isModified?()
      @addClass('modified') unless @isModified
      @isModified = true
    else
      @removeClass('modified') if @isModified
      @isModified = false
