
# Docker Helper (docker_helper or dh)

Docker commands can be verbose sometimes and often you may need to run a series of commands in a specific order in order to get to the desired state.  In order to help assist with this I've created docker_helper or dh for short.  

This version of docker_helper is an abridged version used at [Dose](http://www.dose.com).  The version used at Dose includes additional commands that mirror our deployment pipeline process ensuring developers can build the project locally the same way our pipeline will deploy it.

## How to use

The easiest way to use the `dh` functions is to source the `docker_helper.sh` file into your bash profile.  You can do this by adding the following to your `.bash_profile`

```
# Load docker_helper scripts
source ~/path/to/cloned/repo/docker_helper/docker_helper.sh
```

## functions

You can view all available functions by typing `dh`, give gives you the following:

```
$ dh
 Welcome to the Dose docker_helper help menu.

Available functions:
 Docker-Machine Helpers
	 * dh_create_machine {machine name} - Creates a docker-machine named {machine name} with 2 GB of RAM
		 example:  dh_create_machine clowder  - would create a docker-machine named "clowder"
	 * dh_switch {machine name} - Switches to a different active machine
		 example:  dh_switch clowder  - would activate the docker-machine named "clowder"
	 * dh_ssh_m {machine name} - SSH into a specific docker-machine
		 example:  dh_ssh_m clowder  - would ssh into the docker-machine named "clowder"
 Misc. Utility & Cleanup Helpers
	 * dh_ssh_c {container name} - SSH into a specific container on the active machine
	 * dh_kill - Kill/Stop all running containers
	 * dh_d_volumes - Destroy all docker volumes on your host system
	 * dh_wipe - Stop all running containers and delete everything! (go back to when you had nothing local)
	 * dh_sd_images {regex} - Search images and remove any found images match the regex passed in
	 * dh_sd_running {regex} - Search & destroy running containers that match the regex passed in
	 * dh_sd_project {project name} - Search & destroy docker project images and containers
	 * dh_clean - Delete all stopped containers & untagged images
	 * dh_clean_c - Delete all stopped containers
	 * dh_clean_i - Delete all untagged images
   ```

   All executed commands will print to the screen the complete command they are executing so you will know what command(s) are being sent to the docker daemon.  

   NOTE: The output is currently best formatted for a dark (i.e. black background) terminal screen.
