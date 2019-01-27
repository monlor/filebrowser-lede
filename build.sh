#!/bin/sh

mkdir history &> /dev/null
mv filebrowser.tar.gz history/
tar zcvf filebrowser.tar.gz filebrowser
