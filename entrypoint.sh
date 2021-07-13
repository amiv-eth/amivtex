#!/bin/bash
# Amivtex required the DIN Pro fonts, which are not public and can therefore
# not be part of the public build.
# This entrypoint script allows the container to install the fonts when it is
# started, check the README for the different ways to provide the fonts.

FONT_NAME="Din Pro"
FONT_DIR=~/.local/share/fonts

function error() {
	echo "Error while aquiring DIN Pro fonts:"
	case $1 in
		"no-url") echo "No URL or archive provided.";;
		"bad-url") echo "The provided URL is wrong.";;
		"bad-archive") echo "The archive could not be unpacked";;
		"bad-content") echo "The archive did not contain the DIN Pro fonts."
	esac
	echo "Check the README for instructions how to provide the fonts."
	exit 1
}

# If fonts are not installed, try to aquire them
if ! fc-list | grep -qi "$FONT_NAME"; then
	echo "Fonts missing, installing..."
	# Make sure directory for fonts exists
	mkdir -p $FONT_DIR

	# Different possibilities to aquire font: archive > url > url in file
	if [ -n "$FONT_ARCHIVE" ]; then
		echo "Archive provided, unpacking..."
		tar -xz -C $FONT_DIR -f $FONT_ARCHIVE || error bad-archive
	else
		echo "No archive provided."
		if [ -n "$FONT_URL" ]; then
			echo "Reading URL from environment...";
			url=$FONT_URL;
		elif [ -f $FONT_URL_FILE ]; then
			echo "Readind URL from file...";
			url=$(cat $FONT_URL_FILE);
		else
			error no-url
		fi

		echo "Downloading fonts from URL: $FONT_URL"

		temp_archive=/tmp/fonts_temp.tar.gz
		wget -qO $temp_archive $url || error bad-url
		echo "Unpacking..."
		tar -xz -C $FONT_DIR -f $temp_archive || error bad-archive
		rm $temp_archive
	fi

	# Check if the archive actually contained the fonts
	echo "Checking installation..."
	fc-list | grep -qi "$FONT_NAME" || error bad-content
	echo "Done!"
fi

# Execute CMD
exec "$@"
