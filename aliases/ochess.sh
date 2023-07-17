#!/bin/bash
source "$HOME/.kish/lib/util.sh"
 st="oyt"
 cmd="open lichess for analysis, puzzles then new game in order to improve."
 qkey=""
 paths=$(join '+' $@)


open --url "https://lichess.org/"
open --url "https://lichess.org/training"
open --url "https://lichess.org/@/Zasputin/all"

# todo: open analysis after game? / open analysis of previous game.
