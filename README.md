# IngeniaApp
### Code Challenge

Gists are a way for people to share their work.  Build a viewer app for browsing public gists.
Gists should be rendered in a table view in reverse chronological order (latest on top)
Each row should contain information about the owner and the FIRST file. Include these info:

* The owner’s avatar
* The owner’s login
* The file name in bold. 
* The description 
* The time/date gist was created in a user-friendly format
* The number of comments
* Click on the file name will take the user to a detail screen with the file’s text displayed in the best format you can.
 
Implement pull to refresh AND auto refresh (every 15 minutes ). New gists should be added to the table.
The list should scroll quickly.

**Uri = "https://api.github.com/gists/public”**
