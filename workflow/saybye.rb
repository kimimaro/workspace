##!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative 'common'
require "alfred"

# require handler class on demand
require 'alfred/handler/callback'
require 'mixlib/shellout'
require 'launchy'

class Bye < ::Alfred::Handler::Base

  attr_accessor :close_apps_hash, :vague_commands

  def initialize(alfred, opts = {})
    super
  end

  def on_parser
    ;
  end

  def on_feedback
    query = ARGV[0]

    # close Apps
    app_list = INVOKE_APPS_HASH[query.to_sym]
    if not app_list.nil?
      for app_name in app_list
        close_and_message(app_name)
      end
    end

    script_app_list = SCRIPT_INVOKE_APPS_HASH[query.to_sym]
    if not script_app_list.nil?
      for app_name in script_app_list
        close_and_message(app_name)
      end
    end
  end

  def on_action(arg)
    return unless action?(arg)
  end

  private

  def close_and_message(app_name, opts = {})
    LOGGER.debug "close and message #{app_name}"

    # trick 的方法在Ruby中调用AppleScript
    osascript <<-END
     tell application "#{app_name}"
      quit
     end tell
    END
  end
end

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true
  alfred.with_help_feedback = true
  
  Bye.new(alfred).register
end
