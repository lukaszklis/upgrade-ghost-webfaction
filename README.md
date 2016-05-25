# Upgrade Ghost on WebFaction

I built a super small and lame Bash script (since I don't know bash that much). The script still is not perfect and it has some dependencies:

* It assumes you have already created a Ghost app in WebFaction's admin panel.
* It doesn't make sure that a zip file for a given version exists on Ghost's website.
* It assumes you have already a directory called `shared` in your app's root folder with a copy of the `config.js` file, and `content/{data,images,themes}` directories. Please note, themes directory is optional (script might need some adjustments though).
* It doesn't remove the previous version of Ghost stored in your app's root folder.

Any feedback or suggestions on how to improve it are welcome. Feel free to create
an issue or open a Pull Request.
