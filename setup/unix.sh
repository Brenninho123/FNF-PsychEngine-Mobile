#!/bin/sh
# SETUP FOR MAC AND LINUX SYSTEMS!!!
# REMINDER THAT YOU NEED HAXE INSTALLED PRIOR TO USING THIS
# https://haxe.org/download
set -e

cd "$(dirname "$0")/.."

echo Setting up haxelib...
mkdir -p "$HOME/haxelib"
haxelib setup "$HOME/haxelib" --quiet

echo Installing dependencies...
echo This might take a few moments depending on your internet speed.
haxelib install hxcpp --quiet
haxelib install lime 8.1.2 --quiet
haxelib install openfl 9.3.3 --quiet
haxelib install flixel 5.6.1 --quiet
haxelib install flixel-addons 3.2.2 --quiet
haxelib install flixel-tools 1.5.1 --quiet
haxelib install hscript-iris 1.1.3 --quiet
haxelib install tjson 1.4.0 --quiet
haxelib install hxdiscord_rpc 1.2.4 --quiet
haxelib install hxvlc 2.0.1 --quiet --skip-dependencies
haxelib install extension-androidtools 2.2.2 --quiet
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e --quiet
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit 1906c4a96f6bb6df66562b3f24c62f4c5bba14a7 --quiet
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90 --quiet
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666 --quiet
haxelib set lime 8.1.2
haxelib set openfl 9.3.3
echo Finished!
