hound-data-stash
================

The hound-data-stash container can be used to automatically configure
[hound](https://github.com/etsy/hound) to index all repositories on an
[Atlassian Stash™](https://www.atlassian.com/software/stash) server.

hound-data-stash is designed to be used as a data volume container for the
official [hound container](https://registry.hub.docker.com/u/etsy/hound/).

Quick Start
-----------

To generate a new data container for your hound instance, just run a new
instance of this container, passing in the URL to your Atlassian Stash™
instance:

    $ docker run \
        --name hound-data \
        -e "STASH_URL=http://example.com/stash" \
        jleight/hound-data-stash

A `config.json` file will then be generated in the container's `/hound`
directory that contains all of your public repositories. You can then use this
configuration by specifying `--volumes-from` on your hound container:

    $ docker run \
        --name hound \
        -p 6080:6080 \
        --volumes-from hound-data \
        etsy/hound

Usage
-----

If your projects and repositories in Atlassian Stash™ are configured as public,
you should be able to use the [Quick Start](#quick-start) section to get hound
up and running.

### Private Repositories and Projects

If you need to access private projects and repositories, you can specify a
username and password to connect with when polling for repositories via extra
environment variables:

    $ docker run \
        --name hound-data \
        -e "STASH_URL=http://example.com/stash" \
        -e "STASH_USER=someuser" \
        -e "STASH_PASS=somepassword" \
        jleight/hound-data-stash

The actual hound container can then be started via the same command in the
[Quick Start](#quick-start) section.

### Finding New Projects and Repositories

If you add a new project or repository to your Atlassian Stash™ instance, you
will need to regenerate hound's configuration file. This can easily be
accomplished by starting the data container:

    $ docker start hound-data

Once the container starts, the configuration file will be regenerated. You can
then restart your hound container to find the new repositories:

    $ docker restart hound
