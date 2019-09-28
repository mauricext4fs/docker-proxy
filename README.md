# docker-proxy

## installation
`make up`

## wut?

This is dynamic reverse proxy for docker in docker.

It monitors the docker-deamon anny added or removed containers, and re-generate the proxy configuration on the fly when that happens.

Note : This project is more or less a fork of : https://github.com/jwilder/nginx-proxy

## How do I get docker-proxy to route to my container?
1 - Add your docker to the www-gateway network.
2 - Set a VIRTUAL_HOST environment variable to tell it what host to route to your container.

For example : 
```
version: '3'

services:
 my-container:
        imegage: what-ever
        networds: 
            - www-gateway
            - default
        environments:
            - VIRTUAL_HOST=something.com

networks:
  www-gateway:
    external: true

```

It's also probably a good idea to add  `docker network create www-gateway` somewhere in your Makefile, so it does not crash if you start your project without docker-proxy

## advance options
docker-gen, the hearth of this project have a few more `VIRTUAL_*` variables that you use for more advance usage.
See : https://github.com/jwilder/docker-gen
 
## nginx config
The nginx config is created via a template `nginx.tmpl`
and you can see the current config by running `make show-nginx-conf`

