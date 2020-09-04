#!/bin/sh

set -eu

on_exit() {
  rm -rf "${tmp}"
}

error_handler() {
  # エラー時の処理
  on_exit
}

cmdname=$(basename "${0}")
error() {
  printf '\e[31m%s: エラー: %s\e[m\n' "${cmdname}" "${1}" 1>&2
  printf '\e[31m%s: 終了します\e[m\n' "${cmdname}" 1>&2
  exit 1
}

trap error_handler EXIT

# ここで通常の処理
tmp="$(mktemp -d)"

stty -F /dev/ttyACM1 raw 9600

co2="$(tail -n 1 /var/local/co2mon/DATA/log/co2/latest | cut -d ' ' -f 2 | cut -d '=' -f 2 | tr -d '\r')"
echo $co2 |tee /dev/ttyACM1

# ここで通常の終了処理
on_exit

# 異常終了時ハンドラの解除
trap '' EXIT
