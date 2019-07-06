FROM ubuntu:18.04
RUN apt-get update && apt-get install wget \
    apache2 \
    libdigest-md5-perl \
    libapache2-mod-perl2 \
    libarchive-zip-perl \
    libcrypt-eksblowfish-perl \
    libcrypt-ssleay-perl \
    libtimedate-perl \
    libdatetime-perl \
    libdbi-perl \
    libdbd-mysql-perl \
    libdbd-odbc-perl \
    libdbd-pg-perl \
    libencode-hanextra-perl \
    libio-socket-ssl-perl \
    libjson-xs-perl \
    libmail-imapclient-perl \
    libio-socket-ssl-perl \
    libauthen-sasl-perl \
    libauthen-ntlm-perl \
    libapache2-mod-perl2 \
    libnet-dns-perl \
    libnet-ldap-perl \
    libtemplate-perl \
    libtemplate-perl \
    libtext-csv-xs-perl \
    libxml-libxml-perl \
    libxml-libxslt-perl \
    libxml-parser-perl \
    libyaml-libyaml-perl -y && \
    rm -rf /var/lib/apt/list/*
RUN wget https://ftp.otrs.org/pub/otrs/otrs-6.0.19.tar.gz --directory-prefix=/tmp && \
    tar xzf /tmp/otrs-6.0.19.tar.gz --directory=/opt/ && \
    rm -rf tmp/otrs* && \
    mv /opt/otrs*/ /opt/otrs/
RUN perl -MCPAN -e shell
RUN useradd -d /opt/otrs -c 'OTRS user' otrs
RUN usermod -G www-data otrs
RUN cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm
RUN ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/zzz_otrs.conf
RUN a2enmod perl && \
    a2enmod deflate && \
    a2enmod filter && \
    a2enmod headers
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN service apache2 restart
RUN /opt/otrs/bin/otrs.SetPermissions.pl

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
