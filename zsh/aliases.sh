#!/usr/bin/env zsh

# ==================================================================
# Aliases
# ==================================================================

# Simple clear command.
alias cl='clear'

# Disable certificate check for wget.
alias wget='wget --no-check-certificate'

# Package managers.
alias bi='bower install'
alias bis='bower install --save'
alias ni='npm install'
alias nis='npm install --save'
alias nibi='npm install && bower install'
alias nibir='rm -rf {bower_components,node_modules} && npm install && bower install'
alias ns='npm search'

# Nginx short-cuts.
alias ngup='sudo nginx'
alias ngdown='sudo nginx -s stop'
alias ngre='sudo nginx -s stop && sudo nginx'
alias nglog='tail -f /usr/local/var/log/nginx/access.log'
alias ngerr='tail -f /usr/local/var/log/nginx/error.log'

# Checks whether connection is up.
alias net="ping ya.ru | grep -E --only-match --color=never '[0-9\.]+ ms'"

# Pretty print json
alias json='python -m json.tool'

# Burl: better curl shortcuts (https://github.com/visionmedia/burl).
if (( $+commands[burl] )); then
  alias GET='burl GET'
  alias HEAD='burl -I'
  alias POST='burl POST'
  alias PUT='burl PUT'
  alias PATCH='burl PATCH'
  alias DELETE='burl DELETE'
  alias OPTIONS='burl OPTIONS'
fi

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
