Deletes local backups from the /backup directory.   Default is to keep 4 backups


To install the addon.  Copy the url from Code button.  In home Assistant, select Supervisor/Add-on Store.   Select options (the three dots in the upper right corner) and select Repositories.  and paste the Github url
and add the repositiory.   Next select the options and select Reload.  The addon should now appear in the store listings.

Select addon and click install.

Once complete. Then set the number backups you want to keep and save the configuration.

The addon does not have to be started, as it simply runs through and stops.   The best way to use in an automation is to call Service, select hassio.addon_start and select the addon slug in the drop down box.

You can call from the Developer Tools to test.


