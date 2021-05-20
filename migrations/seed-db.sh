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

make post-authored-video-auth \
  TITLE="Cool Loki in 30 Seconds" \
  DESCRIPTION="Tom Hiddleston is on the clock." \
  URL="https://www.youtube.com/embed/7LydHN2_eE4" \
  FIRSTNAME="Tom" \
  LASTNAME="Hiddleston" \
  AGE="36" \
  EMAIL="video@youtube.com"

make post-authored-video-auth \
  TITLE="Cool Paul Mooney Black Hollywood 1984" \
  DESCRIPTION="All of scenes of comedian Paul Mooney in British documentary BLACK HOLLYWOOD." \
  URL="https://www.youtube.com/embed/dX316_tNx5A" \
  FIRSTNAME="Paul" \
  LASTNAME="Mooney" \
  AGE="79" \
  EMAIL="video@youtube.com"

make post-authored-video-auth \
  TITLE="Cool BAJORNS: Cultural Index" \
  DESCRIPTION="Learn about the Bajorn culture." \
  URL="https://www.youtube.com/embed/qYWzGPI_SME" \
  FIRSTNAME="Star" \
  LASTNAME="Trek" \
  AGE="36" \
  EMAIL="video@youtube.com"

make post-authored-video-auth \
  TITLE="Cool You CAN do deep squats, my friend!" \
  DESCRIPTION="Learn how to do deep squats." \
  URL="https://www.youtube.com/embed/z3XQ7T4-abQ" \
  FIRSTNAME="Hybrid" \
  LASTNAME="Calisthenics" \
  AGE="36" \
  EMAIL="video@youtube.com"
