# Player
A simple iOS app to play a video when it is run.

## How to use: Summary

### On the Mac:

Drag files from the Finder to **Player**’s icon in the Files pane of the iPhone’s Finder window.

Right click on a file to get a delete menu item.

### in the iOS app: 

Select files to send them to other apps.

See  https://github.com/DavidPhillipOster/fileboss/ for a README that is similar to this one.

In the source code, you can edit the legal list of file extensions.

### How it works:

**Player** makes its Documents directory available to the Finder (setting `UIFileSharingEnabled true` in its Info.plist)

### Compatibility : 

**Player** has been tested and works on iOS 13 through iOS 14. Has Dark Mode support.

### Build Instructions

Set the bundle ID to your bundle ID. Adjust the code signing.

