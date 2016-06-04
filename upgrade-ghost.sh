#!/bin/bash

APPNAME=$1
VERSION=$2
APP_DIR=~/webapps/$APPNAME
VERSION_DIR=$APP_DIR/$VERSION
ZIPNAME=ghost-$VERSION.zip

if [ -z "${APPNAME}" ]; then
  echo "Specify app's name!"
elif [ -z "${VERSION}" ]; then
  echo "Specfiy Ghost's version!"
else
  # Create a directory for the new version of Ghost
  cd "$APP_DIR"
  mkdir "$VERSION"
  cd "$VERSION"

  # Fetch a zip file for a specified version
  curl -LOk "https://ghost.org/zip/$ZIPNAME"
  unzip -uo "$ZIPNAME"
  rm "$ZIPNAME"

  # Re-create symlinks
  cd "$APP_DIR"
  rm ghost
  ln -s "$VERSION" ghost

  # Remove folders from version's content/ folder (since we have a shared directory out there)
  cd "$VERSION_DIR/content/"
  rm -rf data/
  rm -rf images/

  # Add node and npm to the PATH
  cd "$APP_DIR"
  export PATH=$PWD/bin/:$PATH

  # Install all of the dependencies
  cd "$VERSION_DIR"
  "$APP_DIR/bin/npm" install --production

  # Create symlinks for the shared content (config, DB, images, custom themes)
  ln -s "$APP_DIR/shared/config.js" "$VERSION_DIR/config.js"
  ln -s "$APP_DIR/shared/content/data" "$VERSION_DIR/content/data"
  ln -s "$APP_DIR/shared/content/images" "$VERSION_DIR/content/images"

  # Install forever
  cd "$VERSION_DIR"
  "$APP_DIR/bin/npm" install forever

  # Restart Ghost
  "$APP_DIR/bin/stop"
  "$APP_DIR/bin/start"
fi
