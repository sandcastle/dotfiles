#!/usr/bin/env bash

log_info "Running Linux initialization..."

if ! is_linux; then
    log_info "Skipping Linux initialization on non-Linux system"
    exit 0
fi
