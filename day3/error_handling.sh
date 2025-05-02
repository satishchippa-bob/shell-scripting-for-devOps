#!/bin/bash

create_directory()
{
	mkdir demo
}
if ! create_directory; then
	echo "the code is beig exited as the directory already excited"
	exit 1
fi

echo " this  should not work becuse the code is interrupted"

