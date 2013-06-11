# Creating a release

Release are creating using grunt (http://gruntjs.com/). You should have grunt-cli installed globally (http://gruntjs.com/getting-started).

1. Determine the new version number, e.g. 0.2.1
2. Start the release 

    git-flow release start 0.2.1

3. Update the version number in package.json
4. Create the zip files:

    $ grunt package

This will create the gem in dist/, e.g. dist/playcaptcha-0.2.1.gem

5. Commit the new package.json and the gem file in dist/
6. Finish the release

    $ git-flow release finish 0.2.1
