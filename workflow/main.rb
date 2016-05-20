 #!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
# require "bundle/bundler/setup"
require "alfred"


Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  # add a file feedback
  # fb.add_file_item(File.expand_path "~/Applications/")

  # add an arbitrary feedback
  fb.add_item({
    :uid      => ""                     ,
    :title    => "Working"          ,
    :subtitle => "知乎"        ,
    :arg      => "work" ,
    :valid    => "yes"                  ,
  })

  # add an feedback to test rescue feedback
  fb.add_item({
    :uid          => ""                     ,
    :title        => "Chat" ,
    :subtitle     => "聊天" ,
    :arg          => "chat"                     ,
    :valid        => "yes"                   ,
  })

  # add an feedback to test rescue feedback
  fb.add_item({
    :uid          => ""                     ,
    :title        => "Reading" ,
    :subtitle     => "阅读" ,
    :arg          => "read"                     ,
    :valid        => "yes"                   ,
  })

  # add an feedback to test rescue feedback
  fb.add_item({
    :uid          => ""                     ,
    :title        => "Coding" ,
    :subtitle     => "敲代码" ,
    :arg          => "code"                     ,
    :valid        => "yes"                   ,
  })

  # add an feedback to test rescue feedback
  #fb.add_item({
  #  :uid          => ""                     ,
  #  :title        => "Note" ,
  #  :subtitle     => "笔记" ,
  #  :arg          => "note"                     ,
  #  :valid        => "yes"                   ,
  #})

  # add an feedback to test rescue feedback
  #fb.add_item({
  #  :uid          => ""                     ,
  #  :title        => "Alfred" ,
  #  :subtitle     => "Alfred Script" ,
  #  :arg          => "alfred"                     ,
  #  :valid        => "yes"                   ,
  #})

  # if ARGV[0].eql? "failed"
  #   alfred.with_rescue_feedback = true
  #   raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  # end

  puts fb.to_xml(ARGV)
end



