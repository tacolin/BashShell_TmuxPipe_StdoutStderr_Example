#!/usr/bin/env bash

# 第一個產生的 window 是 taco:0
tmux new-session -s taco -d -n win0

# 第二個產生的 window 是 taco:1
# tmux new-window -t taco -n win1

# 把 taco:0 切成 左右各半
# 左邊的 pane 是 taco:0.0，右邊的 pane 是 taco:0.1
tmux split-window -t taco:0 -h  

# 把 taco:1 切成 上下各伴
# 上邊的 pane 是 taco:1.0，下邊的 pane 是 taco:1.1
# tmux split-window -t taco:1 -v

# 先選 window taco:0
tmux select-window -t taco:0
# 再選 pane taco:0.0
tmux select-pane -t taco:0.0
# 把 taco:0.0 切成 上下兩等份，左上面是 taco:0.0 原本的
# 左下面那個新切的會是 taco:0.1
# 右邊是 taoc:0.2
tmux split-window -t taco:0.0 -v

# 選 taco:0.2
tmux select-pane -t taco:0.2
# 再切，右下角會變成 taco:0.3
tmux split-window -t taco:0.2 -v

# c-m 是 enter，在各區塊 (pane) 執行 nc -l 去收東西
tmux send-keys -t taco:0.1 "nc -l 6666" "c-m"
tmux send-keys -t taco:0.2 "nc -l 7777" "c-m"
tmux send-keys -t taco:0.3 "nc -l 8888" "c-m"

# 在左上角跑 ./test.py 的那一串
# 一開始的 sleep 如果不睡的話好像會出事  是因為 tmux 的關係
tmux send-keys -t taco:0.0 "sleep 1" "c-m"
tmux send-keys -t taco:0.0 "(./test.py | nc localhost 6666) 2>&1 | tee >(nc localhost 7777) | grep --line-buffered error | nc localhost 8888" "c-m"

tmux set -g mode-mouse on
tmux set -g mouse-resize-pane on
tmux set -g mouse-select-pane on
tmux set -g mouse-select-window on

tmux attach -t "taco"
