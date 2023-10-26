# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

# Get the Linux version but remove the "-1-ARCH" part
# linux_version=$(uname -r | cut -d '-' -f1)

# Returns the battery status: "Full", "Discharging", or "Charging".
# battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

audio_volume=$(amixer -M get Master | awk '/Front Left:.+/ {print $6=="[off]" ? " 🔇"$5: " 🔉"$5}' |tr -d [])

# Additional emojis and characters for the status bar:
# Electricity: ⚡ ↯ ⭍ 🔌
# Audio: 🔈 🔊 🎧 🎶 🎵 🎤
# Separators: \| ❘ ❙ ❚
# Misc: 🐧 💎 💻 💡 ⭐ 📁 ↑ ↓ ✉ ✅ ❎

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
ip_address=$(hostname -I)
# interface_easyname grabs the "old" interface name before systemd renamed it
interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
#ping=$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

# Others
language=$(swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')
loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

if [ $battery_status = "discharging" ];
then
    battery_pluggedin='🔋'
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]
then
   network_active="🚫 no connection"
else
   network_active="📡"
fi

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
echo ⏳ $uptime_formatted '·' $network_active $ip_address $interface_easyname '·'🔥 $loadavg_5min '·' $battery_pluggedin $battery_charge '·' $audio_volume '·' 🎹 $language '·' 🕑 $date_formatted
