#!/bin/bash

# helper functions
echo_run() {
  # NOTE: Cannot be used with functions that already have an "eval" inside of them
  printf "$C_RED Running Command: $C_END "
  printf "$C_YELLOW"
  echo "$@"
  printf "$C_END \n"
  eval "$@"
}

echo_no_run() {
  # NOTE: This does not run the command - you will still need to run the command
  printf "$C_RED Running Command: $C_END "
  printf "$C_YELLOW"
  echo "$@"
  printf "$C_END \n"
}

# Settings
C_RED="\033[0;31m"
C_YELLOW="\033[0;33m"
C_BLUE="\033[0;34m"
C_END="\033[0;0m"

docker_helper(){
  printf "$C_YELLOW Welcome to the docker_helper help menu. $C_END \n\n"
  printf "Available functions: \n"

  # Misc. Utility Helpers
  printf "$C_YELLOW Misc. Utility & Cleanup Helpers $C_END \n"

  printf "\t * dh_ssh_c {container name} - SSH into a specific container on the active machine \n"
  printf "\t * dh_busy_i {image name} - Start a container overriding the entry/cmd for debugging \n"
  printf "\t * dh_logs_c {container1_name} {container2_name} ... - Tails logs from each specified container \n"

  printf "\t * dh_kill - Kill/Stop all running containers \n"
  printf "\t * dh_d_volumes - Destroy all docker volumes on your host system \n"
  printf "\t * dh_wipe - Stop all running containers and delete everything! (go back to when you had nothing local) \n"

  printf "\t * dh_sd_images {regex} - Search images and remove any found images match the regex passed in \n"
  printf "\t * dh_sd_running {regex} - Search & destroy running containers that match the regex passed in \n"
  printf "\t * dh_sd_project {project name} - Search & destroy docker project images and containers \n"

  printf "\t * dh_clean - Delete all stopped containers & untagged images \n"
  printf "\t * dh_clean_c - Delete all stopped containers \n"
  printf "\t * dh_clean_u - Delete all untagged images \n"
}

# help aliases
dh() { docker_helper; }
dh_help() { docker_helper; }

# Misc. Utility Helpers
dh_sd_images() {
  printf "$C_RED Deleting images with tag: $1 $C_END \n"
  echo_no_run "docker images | grep $1 | awk '{print $3}' | xargs docker rmi -f"
  docker images | grep $1 | awk '{print $3}' | xargs docker rmi -f
}

dh_sd_running() {
  printf "$C_RED Stopping & Removing containers with tag: $1 $C_END \n"
  echo_no_run "docker ps | grep $1 | awk '{print $1}' | xargs docker kill"
  docker ps | grep $1 | awk '{print $1}' | xargs docker kill
  echo_no_run "docker ps -a | grep $1 | awk '{print $1}' | xargs docker rm"
  docker ps -a | grep $1 | awk '{print $1}' | xargs docker rm
}

dh_d_volumes() {
  printf "$C_RED Deleted all volumes on active docker-machine $C_END \n"
  echo_run "docker volume ls | awk '{if (NR!=1) {print $2}}' | xargs docker volume rm"
}

dh_kill() {
  printf "$C_RED Killing all running containers $C_END \n"
  echo_run "docker ps -q | xargs docker kill"
}

dh_clean_c(){
  printf "$C_RED Deleting stopped containers $C_END \n"
  echo_run "docker ps -a -q | xargs docker rm"
}

dh_clean_u(){
  printf "$C_RED Deleting untagged images $C_END \n"
  echo_run "docker images -q -f dangling=true | xargs docker rmi -f"
}

dh_ssh_c() {
docker exec -it $1 bash
}

dh_busy_i() {
  docker run -d --entrypoint /bin/sh $1 -c "while true; do echo hello world; sleep 1; done"
}

# Combined funcs
dh_sd_project() {
dh_sd_running $1
dh_sd_images $1
}

dh_clean(){
# Delete all stopped containers and untagged images.
dh_clean_c
dh_clean_u
}

dh_wipe(){
printf "$C_RED Removing all images & containers on active docker-machine $C_END \n"
dh_kill
dh_clean_c
dh_clean_u
printf "$C_RED Deleting images $C_END \n"
echo_run "docker images -q | xargs docker rmi -f"
}

dh_logs_c() {
  while [ $# -ne 0 ]
  do
      (docker logs -f -t --tail=10 $1|sed -e "s/^/$1: /")&
      shift
  done
  wait
}
