# sublime-tabs

This enables sublime-style tabs in Atom.

Normally, the Tabs package will open a new tab for each file, and it will stay open even if you don't edit it.

sublime-tabs enables you to click a file through the Tree View on the left, it will open it as a "temp" file like sublime does,
and will close the tab if another tab is opened without you editing it.

[![Build Status](https://travis-ci.org/ddavison/sublime-tabs.svg)](https://travis-ci.org/ddavison/sublime-tabs)

![example](https://raw.githubusercontent.com/ddavison/sublime-tabs/master/images/example.gif)

## To Use
Install either through the Atom package search, or by:
```sh
$ apm install sublime-tabs
```

This is a replacement for the `Tabs` and `Tree View` package.  Open your Settings, and disable both the `Tabs` and `Tree View` package by searching for it and clicking "Disable" on them.
If you don't do this, you will see multiple tree or tab views.

## If for some reason...
sublime-tabs is not working... try:
* Making sure sublime-tabs is installed, enabled, and up to date
* Making sure the `Tabs` package is disabled.
* Making sure the `Tree View` package is disabled.
* Restart Atom
* Right click somewhere in an open file, and click `Reveal in tree view`

## Uninstall
This is an early version, so it *may* screw things up.  If it does, you can re-enable `Tabs` and `Tree View`, and disable `sublime-tabs`.
