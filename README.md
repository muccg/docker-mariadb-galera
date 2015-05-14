# About this Repo

This Git repo is derived from the official Docker image for [mariadb](https://registry.hub.docker.com/_/mariadb/).

The basic behaviour of the official mariadb container is preserved (initialisation, users, passwords and so on).

Support for Galera clustering has been added. Configuration is via /etc/mysql/conf.d which is a volume. To active Galera you need to mount
that volume and put a appropriate .cnf file in there. A sample cluster.cnf for bootstrapping a cluster is provided.

Extra ports are exposed for the clustering. Bootstrapping the cluster is the same - refer to the official docs for [galera](http://galeracluster.com/documentation-webpages/).
