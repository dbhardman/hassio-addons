The title is a little misleading as the addon only copies existing
backup files to an external drive using the folders available in Hassio

Based on work by NotoriusBDG   https://community.home-assistant.io/t/snapshot-service-enhancement-to-usb-dongle/43202/2

Prior to installing this addon you need a way to mount the usb drive.
The best method I found was this:  https://gist.github.com/eklex/c5fac345de5be9d9bc420510617c86b5
This process survives reboots and upgrades.   Follow the directions in the post above then reboot the Host from the supervisor/system in home assistant.

To install the addon.  Copy the url from Code button.  In home Assistant, select Supervisor/Add-on Store.   Select options (the three dots in the upper right corner) and select Repositories.  and paste the Github url
and add the repositiory.   Next select the options and select Reload.  The addon should now appear in the store listings.

Select addon and click install.

Once complete, select the configuration tab and ensure the path is set as per the path you used in the rules file.   Set the number backups you want to keep internally and externally and save the configuration.

The addon does not have to be started, as it simply runs through and stops.   The best way to use in an automation is to call Service, select hassio.addon_start and select the addon slug in the drop down box.

Version 0.0.03 added the ability to resore backups from the usb key

You can call from the Developer Tools to test.


