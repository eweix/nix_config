#!/usr/bin/env bash
# https://privacy.sexy — v0.13.8 — Sat, 05 Jul 2025 23:18:53 GMT
if [ "$EUID" -ne 0 ]; then
    script_path=$([[ "$0" = /* ]] && echo "$0" || echo "$PWD/${0#./}")
    sudo "$script_path" || (
        echo 'Administrator privileges are required.'
        exit 1
    )
    exit 0
fi

echo '--- Clear bash history'
rm -f ~/.bash_history

echo '--- Clear zsh history'
rm -f ~/.zsh_history

echo '--- Clear Mail app logs'
# Clear directory contents: "$HOME/Library/Containers/com.apple.mail/Data/Library/Logs/Mail"
glob_pattern="$HOME/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*"
 rm -rfv $glob_pattern

echo '--- Clear system maintenance logs'
# Delete files matching pattern: "/private/var/log/daily.out"
glob_pattern="/private/var/log/daily.out"
sudo rm -fv $glob_pattern
# Delete files matching pattern: "/private/var/log/weekly.out"
glob_pattern="/private/var/log/weekly.out"
sudo rm -fv $glob_pattern
# Delete files matching pattern: "/private/var/log/monthly.out"
glob_pattern="/private/var/log/monthly.out"
sudo rm -fv $glob_pattern

echo '--- Clear Adobe cache'
sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

echo '--- Clear Dropbox cache'
if [ -d "~/Dropbox/.dropbox.cache" ]; then
    sudo rm -rfv ~/Dropbox/.dropbox.cache/* &>/dev/null
fi

echo '--- Clear Google Drive File Stream cache'
killall "Google Drive File Stream"
rm -rfv ~/Library/Application\ Support/Google/DriveFS/[0-9a-zA-Z]*/content_cache &>/dev/null

echo '--- Clear iOS photo cache'
rm -rf ~/Pictures/iPhoto\ Library/iPod\ Photo\ Cache/*

echo '--- Clear DNS cache'
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

echo '--- Clear inactive memory'
sudo purge

echo '--- Disable Firefox telemetry'
# Enable Firefox policies so the telemetry can be configured.
sudo defaults write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE
# Disable sending usage data
sudo defaults write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE

echo '--- Disable Microsoft Office telemetry'
defaults write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData

echo '--- Disable NET Core CLI telemetry'
command='export DOTNET_CLI_TELEMETRY_OPTOUT=1'
declare -a profile_files=("$HOME/.bash_profile" "$HOME/.zprofile")
for profile_file in "${profile_files[@]}"
do
    touch "$profile_file"
    if ! grep -q "$command" "${profile_file}"; then
        echo "$command" >> "$profile_file"
        echo "[$profile_file] Configured"
    else
        echo "[$profile_file] No need for any action, already configured"
    fi
done

echo '--- Disable Homebrew user behavior analytics'
command='export HOMEBREW_NO_ANALYTICS=1'
declare -a profile_files=("$HOME/.bash_profile" "$HOME/.zprofile")
for profile_file in "${profile_files[@]}"
do
    touch "$profile_file"
    if ! grep -q "$command" "${profile_file}"; then
        echo "$command" >> "$profile_file"
        echo "[$profile_file] Configured"
    else
        echo "[$profile_file] No need for any action, already configured"
    fi
done

echo '--- Disable PowerShell Core telemetry'
command='export POWERSHELL_TELEMETRY_OPTOUT=1'
declare -a profile_files=("$HOME/.bash_profile" "$HOME/.zprofile")
for profile_file in "${profile_files[@]}"
do
    touch "$profile_file"
    if ! grep -q "$command" "${profile_file}"; then
        echo "$command" >> "$profile_file"
        echo "[$profile_file] Configured"
    else
        echo "[$profile_file] No need for any action, already configured"
    fi
done

echo '--- Disable automatic storage of documents in iCloud Drive'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo '--- Disable personalized advertisements and identifier tracking'
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib forceLimitAdTracking -bool true

echo '--- Disable Parallels Desktop advertisements'
defaults write 'com.parallels.Parallels Desktop' 'ProductPromo.ForcePromoOff' -bool yes
defaults write 'com.parallels.Parallels Desktop' 'WelcomeScreenPromo.PromoOff' -bool yes

echo '--- Disable participation in Siri data collection'
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2

echo '--- Enable application firewall'
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo defaults write /Library/Preferences/com.apple.alf globalstate -bool true
defaults write com.apple.security.firewall EnableFirewall -bool true

echo '--- Enable firewall logging'
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true

echo '--- Enable stealth mode'
/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true
defaults write com.apple.security.firewall EnableStealthMode -bool true

echo '--- Disable incoming SSH and SFTP remote logins'
echo 'yes' | sudo systemsetup -setremotelogin off

echo '--- Disable the insecure TFTP service'
sudo launchctl disable 'system/com.apple.tftpd'

echo '--- Disable Bonjour multicast advertising'
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true

echo '--- Disable insecure telnet protocol'
sudo launchctl disable system/com.apple.telnetd

echo '--- Disable local printer sharing with other computers'
cupsctl --no-share-printers

echo '--- Disable printing from external addresses, including the internet'
cupsctl --no-remote-any

echo '--- Disable remote printer administration'
cupsctl --no-remote-admin


echo 'Your privacy and security is now hardened 🎉💪'
echo 'Press any key to exit.'
read -n 1 -s