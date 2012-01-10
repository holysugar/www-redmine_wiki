RedmineWiki
===========

Wiki API is not included in Redmine REST API. And we want to access wiki text easily.

Example
-------

    require 'redmine_wiki'
    wiki = RedmineWiki.new('http://example.com/projects/sample/wiki/')
    wiki.username = 'sample'
    wiki.password = 'xxxxxx'

    text = wiki.get("Sandbox")
    wiki.update("Sandbox", text + "\n\nfoobar")
