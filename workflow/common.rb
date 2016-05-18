#!/usr/bin/env ruby
# encoding: utf-8

require "logger"

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::WARN
LOGGER.level = Logger::DEBUG

INVOKE_APPS_HASH = {
  zhihu:  ["Xcode.app", "Google Chrome.app", "Atom.app", "Dash.app"],
  im:           ["Slack.app", "微信.app"],
  note:         ["Google Chrome.app", "Evernote.app", "MWeb.app"],
}

SCRIPT_INVOKE_APPS_HASH = {
  # im:           ["Microsoft Outlook.app"],
}

INVOKE_FILE_HASH = {
  zhihu: ["~/ws/osee2unified/osee2unified/osee2unified.xcworkspace"],
  # wax: ["~/workspaces/searchbox/baidubox/iOSWorkspace/BaiduBoxApp/Plugins"],
}

INVOKE_URL_HASH = {
  zhihu:  ["http://dashboard.in.zhihu.com/users", "https://inbox.google.com/u/1/", "https://git.in.zhihu.com", "http://ph.in.zhihu.com/project/", "https://calendar.google.com/calendar/b/1/render?tab=wc#main_7"],
  # stock:        ["http://www.eastmoney.com/"],
  im:   ["https://inbox.google.com/"],
  blog:   ["http://402v.com/", "http://402v.com/tag/server/"],
}

INVOKE_COMMAND_HASH = {
  # alfred: ["vim ~/Library/Application\ Support/Alfred\ 2/Alfred.alfredpreferences/workflows/user.workflow.8D49CCE6-8D6A-454C-B0FC-BD59CF8DB081"],
  # wax: ["subl ~/workspaces/searchbox/baidubox/iOSWorkspace/BBAPods/Wax"],
  blog: ["open ~/workspaces/github/octopress_blog/source/_posts", "cd ~/workspaces/github/octopress_blog"],
}

def osascript(script)
  system 'osascript', *script.split(/\n/).map { |line| ['-e', line] }.flatten
end
