
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

All executed commands will print to the screen the complete command they are executing so you will know what command(s) are being sent to the docker daemon.  

NOTE: The output is currently best formatted for a dark (i.e. black background) terminal screen.
