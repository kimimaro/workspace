#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative 'common'
require "alfred"

# require handler class on demand
require 'alfred/handler/callback'
require 'mixlib/shellout'
require 'launchy'



class Hi < ::Alfred::Handler::Base

  attr_accessor :invoke_apps_hash, :invoke_file_hash, :invoke_url_hash, :vague_commands

  def initialize(alfred, opts = {})
    super
  end

  def on_parser
    ;
  end

  def on_feedback
    # action & feedback 的区别

    LOGGER.debug "on feedback was called on #{self.inspect}"

    query = ARGV[0]

    # open Apps
    app_list = INVOKE_APPS_HASH[query.to_sym]
    if not app_list.nil?
      LOGGER.debug "app list #{app_list}"

      for app_name in app_list
        run_and_message("open /Applications/#{app_name}")
      end
    end

    # script open Apps
    script_app_list = SCRIPT_INVOKE_APPS_HASH[query.to_sym]
    if not script_app_list.nil?
      LOGGER.debug "script app list #{script_app_list}"

      for app_name in script_app_list
        run_app_and_message(app_name)
      end
    end

    #open files
    file_list = INVOKE_FILE_HASH[query.to_sym]
    if not file_list.nil?
      LOGGER.debug "file list #{file_list}"

      for file_path in file_list
        run_and_message("open #{file_path}")
      end
    end

    # open URLs
    url_list = INVOKE_URL_HASH[query.to_sym]
    if not url_list.nil?
      LOGGER.debug "url list #{url_list}"

      for url in url_list
        Launchy.open(url)
      end
    end

    # open Command
    cmd_list = INVOKE_COMMAND_HASH[query.to_sym]
    if not url_list.nil?
      LOGGER.debug "cmd list #{cmd_list}"

      for cmd in cmd_list
         system cmd
      end
    end
  end

  def on_action(arg)
    LOGGER.debug "on action was called on #{self.inspect}"

    return unless action?(arg)

    # if arg[:task] == 'callback'
    #   case arg[:type]
    #   when 'iotop'

    #     generate_feedback(iotop)
    #     callback_entry = {
    #       :key => arg[:type],
    #       :title => "Top Workflow Callback",
    #       :subtitle => "IO Top",
    #     }

    #     @callback.on_callback('top', callback_entry, feedback.items )
    #   end

    # else
    #   case options.modifier
    #   when :control
    #     run_and_message("kill #{arg[:pid]}")
    #   when :command
    #     run_and_message("kill -9 #{arg[:pid]}")
    #   when :alt
    #     run_and_message("renice -n 5 #{arg[:pid]}")
    #   when :shift
    #     Alfred::Util.google(%Q{Mac "#{arg[:name]}" process})
    #   when :none
    #     Alfred.search("lsof #{arg[:pid]}")
    #   end
    # end
  end

  private

  def run_and_message(command, opts = {})
    sh = Mixlib::ShellOut.new(command, opts)
    sh.run_command
    puts status_message(command, sh.exitstatus)
  end

  def run_app_and_message(app_name, opts = {})
    LOGGER.debug "run and message #{app_name}"

    # trick 的方法在Ruby中调用AppleScript
    osascript <<-END
     tell application "#{app_name}"
      open
     end tell
    END
  end
end

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true
  alfred.with_help_feedback = true
	
	Hi.new(alfred).register
end
