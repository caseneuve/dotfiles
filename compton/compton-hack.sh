#!/bin/bash
# Last update: 29.01.19, 18:37:15 @x200

# hack to prevent error: "Failed to initialize the backend"
allow_rgb10_configs=false
compton --backend glx &
