#!/bin/bash
hugo
git add .
git commit -m "Update content"
git push origin main
git subtree push --prefix public origin gh-pages