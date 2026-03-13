#!/bin/bash

# file : wallpaper.sh 
# function : sourced by autostart.sh to apply the wallpapers

############################################## WALLPAPERS #########################################

# default wallpaper dir, where random wallpapers are picked from
wall_dir="$HOME/.config/bspwm/walls/"

# is the wallpaper distraction free? like not silly animae sulk? not colour stuffs? just pure black, mission mode?
wall_disfree=true

# where to find those disfree wallpapers?
wall_disfree_dir="$HOME/.config/bspwm/walls/disfree/"

# instead of random wallpaper apply only a single wallpaper?
wall_single=false

# the path of that single wallpaper
wall_wallpaper="$HOME/.config/bspwm/walls.ref/080.png"
