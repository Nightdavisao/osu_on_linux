#!/bin/bash
# Date : (2018-09-30)
# Wine version used : 3.10
# Distribution used to test : Linux Mint 19 Tara 
# Author : Nightdavisao
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="osu!"
PREFIX="osu_on_linux"
WINEVERSION="3.10"
EDITOR="peppy"
GAME_URL="http://osu.ppy.sh/"
AUTHOR="Nightdavisao"
 
# Download images for installation script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
# Initialize the script, debugging
POL_SetupWindow_Init
POL_SetupWindow_SetID 1856
POL_Debug_Init
 
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Install .NET Framework 4.0 and core fonts
POL_Call POL_Install_dotnet40
POL_Call POL_Install_corefonts
 
# Download the required fonts to Japanese characters
cd "$WINEPREFIX/drive_c/windows/Fonts"
POL_Download "https://github.com/Nightdavisao/osu_on_linux/blob/master/osu_on_linux/japanese_fonts/msgothic.ttc" "1f162793323e204a0d598a9aa4241443"
POL_Download "https://github.com/Nightdavisao/osu_on_linux/blob/master/osu_on_linux/japanese_fonts/msmincho.ttc" "ea3f8835f67b492a0740ac34e1e807f8"

# Now create "osu!" folder in Programs Files and download the osu! icon and set the current directory to "osu!" folder
mkdir "$WINEPREFIX/drive_c/$PROGRAMFILES/osu!"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/osu!"
POL_Download "https://github.com/Nightdavisao/osu_on_linux/raw/master/osu_on_linux/icon/osu!.png"

# Download the updater and open it
POL_Download "https://m1.ppy.sh/r/osu!install.exe"
POL_Wine osu!install.exe
 
# Wait for the updater to finish in order to create a shortcut of the executable
POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "osu!.exe" "osu!" "osu!.png"

POL_SetupWindow_Close
exit