fs = require 'fs'
path = require 'path'

module.exports = (wintersmith, callback) ->

  class HtmlPlugin extends wintersmith.ContentPlugin

    constructor: (@_filename, @_text) ->


    getFilename: ->
      @_filename

    render: (locals, contents, templates, callback) ->
      # return the plain HTML file
      callback null, new Buffer @_text

  HtmlPlugin.fromFile = (filename, base, callback) ->
    fs.readFile path.join(base, filename), (error, buffer) ->
      if error
        callback error
      else
        callback null, new HtmlPlugin filename, buffer.toString()
        
  wintersmith.registerContentPlugin 'html', '**/*.html', HtmlPlugin
  callback() # tell the plugin manager we are done
