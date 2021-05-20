#!/bin/bash

set -e

# These actions quickly seed the memory cache with two videos using the Make
# commands for posting an authored video with Basic Auth.

make post-authored-video-auth \
  TITLE="Cool Nintendo Switch headphones" \
  DESCRIPTION="I am not a fan of wireless headphones." \
  URL="https://www.youtube.com/embed/rjAeCX4OBXU" \
  FIRSTNAME="WULFF" \
  LASTNAME="DEN" \
  AGE="36" \
  EMAIL="video@youtube.com"

make post-authored-video-auth \
  TITLE="Cool Steak Pinwheels" \
  DESCRIPTION="A Basics episode about steak." \
  URL="https://www.youtube.com/embed/02NINX8OD-A" \
  FIRSTNAME="Babbish" \
  LASTNAME="Culinary" \
  AGE="36" \
  EMAIL="video@youtube.com"
