# Third Party Mods/Resources Installer for L4D2

## What is this?

A simple script created for linux dedicated l4d2 server admins, which makes downloading mods easier

## Guide

- Update `USERNAME` and `PASSWORD` for your steam account
- Set `CUSTOM_MAPS_PATH` to the location of your third party maps folder
- `chmod +x install.sh` to add execute permission for all users
- `sh install.sh` or `./install.sh` to run the script
- Follow the prompt and enter the mod id which can be found on the steam workshop page
  - This is often the id parameter of the URL, for example mod id = `3151080368` for `https://steamcommunity.com/sharedfiles/filedetails/?id=3151080368`
- Press enter, and grab a coffee while you wait for the download :)

## Dependencies

- **SteamCMD**, which can be downloaded and installed by following [the official guide](https://developer.valvesoftware.com/wiki/SteamCMD#Downloading_SteamCMD)
