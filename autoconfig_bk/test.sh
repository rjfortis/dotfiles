#!/bin/bash

while true; do

	read -p "Do you want to proceed? (y/n) " yn

	case $yn in
		[yY] )
			echo ok, we will proceed;
			break;;
		[nN] )
			echo nothing to do..;
			break;;
		* )
			echo invalid response;;
	esac

done

echo doing stuff...
