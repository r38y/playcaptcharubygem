# Creating a release

Release are creating using grunt (http://gruntjs.com/). You should have grunt-cli installed globally (http://gruntjs.com/getting-started).

1. Determine the new version number, e.g. 0.2.1
2. Start the release 

    git-flow release start 0.2.1

3. Update the version number in package.json
4. Create the zip files:

    $ grunt package

This will create the zip in dist/, e.g. dist/playcaptcha-drupal-v0.2.1.zip

5. Commit the new package.json and the zip file
6. Finish the release

    $ git-flow release finish 0.2.1

7. Push the master branch to the repo

    $ git push origin master && git push origin master --tags
