#!/usr/bin/env ruby
# encoding: utf-8

require "logger"

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::WARN
LOGGER.level = Logger::DEBUG

INVOKE_APPS_HASH = {
  work:   ["Evernote.app", "Google Chrome.app"],
  chat:   ["WeChat.app"],
  read:   ["Google Chrome.app", "Pocket.app"],
  code:   ["Xcode.app", "Atom.app", "Dash.app", "Xcode.app/Contents/Developer/Applications/Simulator.app", "Reveal.app"]
}

CLOSE_APP_HASH = {
  code: ["Simulator.app"] # 与 Invoke 路径不同
}

SCRIPT_INVOKE_APPS_HASH = {
  # im:           ["Microsoft Outlook.app"],
}

INVOKE_FILE_HASH = {
  code: ["~/ws/Zhihu/osee2unified/osee2unified/osee2unified.xcworkspace"],
  # wax: ["~/workspaces/searchbox/baidubox/iOSWorkspace/BaiduBoxApp/Plugins"],
}

INVOKE_URL_HASH = {
  work:  ["https://inbox.google.com/u/1/", "http://ph.in.zhihu.com", "https://calendar.google.com/calendar/b/1/render?tab=wc#main_7", "http://zhihu.ourats.com/v3/", "https://fabric.io/home", "http://ph.in.zhihu.com/project/board/132/query/assigned/?order=priority", "http://ph.in.zhihu.com/differential/"],
  # stock:        ["http://www.eastmoney.com/"],
  # chat:   ["https://inbox.google.com/"],
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
