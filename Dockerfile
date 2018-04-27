FROM alpine:latest
LABEL name="Mariadb docker" version="1.0" description="environnement base de données mariadb"
MAINTAINER "Guillaume de Lestanville <guillaume.delestanville@proximit.fr>"

RUN apk add --update mysql mysql-client bash perl su-exec
RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./my.cnf /etc/mysql/my.cnf
COPY entrypoint.sh /entrypoint.sh

RUN chown -R mysql:mysql /var/lib/mysql
RUN touch /var/log/mysqld.log && chown mysql:mysql /var/log/mysqld.log

VOLUME [ "/var/lib/mysql"]

EXPOSE 3306

WORKDIR /usr
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "mysqld", "--verbose"]

