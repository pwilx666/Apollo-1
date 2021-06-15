# Apollo

This repository contains customimzations to the Apollo (https://github.com/GMOD/Apollo) annotation tool.  It creates 3 custom docker images:

* oauthproxy - this container enables oauth authentication in front of apollo.  It is the front facing service, all public requests route through this container.  It uses apache's mod-auth-openidc.
* postgres - this container is built off of a standard postgres image, we only add a db init script.  This stores apollo data.
* apollo - this container is built off the gmod apollo image, and includes some custom plugins, as well as a few convenience items (such as groovy)

# jenkins
There is a Jenkinsfile to facilitate building these images, given an appropriately configured jenkins.

# Traefik
Routing to the containers is done through Traefik (https://traefik.io/traefik/) Which allows flexibility for container access.  For example, all public requests route through the oauth proxy, but you can still route directly to apollo with apropriate traefik rules.  This is useful for providing access directly to apollo, notably for api access which should bypass oauth. (Examples coming soon)  An example setup for typical veupathdb usage can be found at https://github.com/VEuPathDB/docker-traefik

# Development
After setting up docker and docker-compose, A local apollo instance can be brought up by cloning this repo, and running `docker-compose up -d`.  If you need to work on building images themselves, you can use docker-compose-dev.yml as an overlay with `docker-compose -f docker-compose.yml -f docker-compose-dev.yml up -d`.  This will build the images from the Dockerfile's in this repository.
