#!/usr/bin/env bash

log_h1 "Configuring MacOS system"

# Ask for computer name if not set
if [[ -z "${COMPUTER_NAME}" ]]; then
  COMPUTER_NAME=$(get_computer_name)
  prompt_user "Enter your computer name" COMPUTER_NAME "$COMPUTER_NAME"
fi

if [[ -n "${COMPUTER_NAME}" ]]; then
  set_computer_name "$COMPUTER_NAME"
fi
