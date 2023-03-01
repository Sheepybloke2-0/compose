# compose
A bunch of compose files for the OrangePi stack. This is going to be a set of 
[Orange Pi Zero Pluses](https://linux-sunxi.org/Xunlong_Orange_Pi_Zero_Plus) that are 
connected in a docker swarm. This project is inspired by 
[Haxxnet's compose examples](https://github.com/Haxxnet/Compose-Examples) and an idea
I had a while ago to run a portfolio from a stack of these Orange Pi's.

So far, it has the following services:
 - Code server
 - Obsidian remote
 - Ghost

## Running the system
Setup the system by running `./setup.sh`. This installs the required packages.
Run the systems with `./launch.sh`, and shut the services down with `./shutdown.sh`.
May need to `chmod +x` the different files.

## Obsidian
Currently, there is a bug with running arm64 via the obsidian-remote. There is a fix
outlined in a ISSUE #42, which someone found a fix for. I added the fix to the dockerfile
and included the fixed version in the obsidian directory. To get this to work, you'll
need to clone the [obsidian repo](https://github.com/sytone/obsidian-remote), put in
the fixed file, then build with this command: `docker build -f dockerfile.arm64 . -t obsidian-local`
Then, obsidian should run on the OrangePi.

