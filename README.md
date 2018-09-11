# Mingus.Docker

Docker engine API implementation backed by [Project-FiFo](https://project-fifo.net/)

Supported versions:
* try to support [v1.38](https://docs.docker.com/engine/api/v1.37/)
  but...
* Docker CLI seems to downgrade to
  [1.24](https://docs.docker.com/engine/api/v1.24/), so let's
  implement 1.24 first

# Connection to Project-FiFo

`Mingus.Docker` uses
[libsniffle](https://gitlab.com/Project-FiFo/FiFo/libsniffle) to
gather data from Project-FiFo cluster.

`libsniffle` uses mDNS to discover Sniffle service, which may be
problematic when running through a VPN. My own fork allows for
specifying IP and port manually with application env:

``` elixir
config :libsniffle, sniffle: {'10.1.1.240', 4210}
```

## Configuration

`Mingus.Docker` can listen on UNIX socket:

``` elixir
config :fifo_docker, listen: [
  {{:local, "/tmp/fifo_docker.sock"}, 0}
]
```

## TODO

### [Containers](https://docs.docker.com/engine/api/v1.24/#3-endpoints)

- [ ] List containers
- [ ] Create a container
- [ ] Inspect a container
- [ ] List processes running inside a container
- [ ] Get container logs
- [ ] Inspect changes on a container’s filesystem
- [ ] Export a container
- [ ] Get container stats based on resource usage
- [ ] Resize a container TTY
- [ ] Start a container
- [ ] Stop a container
- [ ] Restart a container
- [ ] Kill a container
- [ ] Update a container
- [ ] Rename a container
- [ ] Pause a container
- [ ] Unpause a container
- [ ] Attach to a container
- [ ] Attach to a container (websocket)
- [ ] Wait a container
- [ ] Remove a container
- [ ] Retrieving information about files and folders in a container
- [ ] Get an archive of a filesystem resource in a container
- [ ] Extract an archive of files or folders to a directory in a container

### [Images](https://docs.docker.com/engine/api/v1.24/#32-images)

- [ ] List Images
- [ ] Build image from a Dockerfile
- [ ] Create an image
- [ ] Inspect an image
- [ ] Get the history of an image
- [ ] Push an image on the registry
- [ ] Tag an image into a repository
- [ ] Remove an image
- [ ] Search images

### [Misc](https://docs.docker.com/engine/api/v1.24/#33-misc)

- [ ] Check auth configuration
- [ ] Display system-wide information
- [ ] Show the docker version information
- [ ] Ping the docker server
- [ ] Create a new image from a container’s changes
- [ ] Monitor Docker’s events
- [ ] Get a tarball containing all images in a repository
- [ ] Get a tarball containing all images
- [ ] Load a tarball with a set of images and tags into docker
- [ ] Image tarball format
- [ ] Exec Create
- [ ] Exec Start
- [ ] Exec Resize
- [ ] Exec Inspect

### [Volumes](https://docs.docker.com/engine/api/v1.24/#34-volumes)

- [ ] Create a volume
- [ ] Inspect a volume
- [ ] Remove a volume

### [Networks](https://docs.docker.com/engine/api/v1.24/#35-networks)

- [ ] List networks
- [ ] Inspect network
- [ ] Create a network
- [ ] Connect a container to a network
- [ ] Disconnect a container from a network
- [ ] Remove a network

### [Plugins](https://docs.docker.com/engine/api/v1.24/#36-plugins-experimental)

Not planned

### [Nodes](https://docs.docker.com/engine/api/v1.24/#37-nodes)

Not planned

### [Swarm](https://docs.docker.com/engine/api/v1.24/#38-swarm)

Not planned

### [Services](https://docs.docker.com/engine/api/v1.24/#39-services)

Not planned

### [Tasks](https://docs.docker.com/engine/api/v1.24/#310-tasks)

Not planned
