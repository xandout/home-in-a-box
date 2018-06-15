# Home In A Box


![screenshot](/screen.png)

## Why

Well, I thought it would be cool.  I was right.


## What

This docker image will run Xfce on Fedora:latest and start a VNC server so you can use your new workstation.

## How

I have not submitted this to Docker Hub because I have not put any effort into verifying that this does not expose some major security risks.  It probably does since you can `sudo` to root.

To build:

`docker build -t home-in-a-box .`

To run:

`docker run --rm -d -v mybox:/home/boxer -p 5901:5901 home-in-a-box`

To customize:

Edit `VNC_PASS` and `BOXED_USER` in Dockerfile and then build: `docker build -t home-in-a-box .`

or with `--build-args`

`docker build -t home-in-a-box --build-arg VNC_PASS=password2 --build-arg BOXED_USER=kickboxer .`

# What doesn't work

Probably everything except the basics.


