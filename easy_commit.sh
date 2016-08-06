#!/bin/bash

echo "commit message: "
read input
git add .
git commit -m "$input"

