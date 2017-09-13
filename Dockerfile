# Derived from https://github.com/docker-library/mariadb
FROM debian:wheezy
LABEL maintainer "https://github.com/muccg"

ARG ARG_MARIADB_VERSION

ENV MARIADB_MAJOR $ARG_MARIADB_VERSION

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

RUN echo "deb [arch=amd64,i386] http://mirror.aarnet.edu.au/pub/MariaDB/repo/$MARIADB_MAJOR/debian wheezy main" > /etc/apt/sources.list.d/mariadb.list \
    && { \
        echo 'Package: *'; \
        echo 'Pin: release o=MariaDB'; \
        echo 'Pin-Priority: 999'; \
    } > /etc/apt/preferences.d/mariadb

RUN apt-get update \
    && apt-get install -y \
    mariadb-galera-server-5.5 net-tools procps \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql \
    && mkdir /var/lib/mysql \
    && sed -ri 's/^(bind-address|skip-networking)/#\1/' /etc/mysql/my.cnf \
    && sed -i "s/^max_connections.*/max_connections = 512/g" /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql", "/etc/mysql/conf.d", "/var/log/mysql"]

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3306 4567 4444 4568
CMD ["mysqld"]
