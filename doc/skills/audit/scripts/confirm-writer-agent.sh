#!/bin/bash
input=$(cat)
prompt=$(echo "$input" | jq -r '.tool_input.prompt // empty')

if ! echo "$prompt" | grep -q '\[SKILL=audit\]'; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  exit 0
fi

if echo "$prompt" | grep -q '\[ROLE=formatting-reviewer\]'; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  exit 0
fi

if echo "$prompt" | grep -q '\[ROLE=grammar-reviewer\]'; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  exit 0
fi

if echo "$prompt" | grep -q '\[PHASE=plan\]'; then
  if echo "$prompt" | grep -q '\[USER_APPROVED=plan\]'; then
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  else
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Phải gọi AskUserQuestion xác nhận trước khi gọi writer phase=plan"}}'
  fi
  exit 0
fi

if echo "$prompt" | grep -q '\[PHASE=execute\]'; then
  if echo "$prompt" | grep -q '\[USER_APPROVED=execute\]'; then
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  else
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Phải gọi AskUserQuestion xác nhận trước khi gọi writer phase=execute"}}'
  fi
  exit 0
fi

echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Marker không hợp lệ trong prompt audit"}}'
