#!/bin/bash

git log $(git describe --abbrev=0 --tags)..HEAD --pretty=format:"* [%h](../../commit/%H) %s"
