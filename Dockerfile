FROM m3hran/baseimage
MAINTAINER Martin Taheri <m3hran@gmail.com>
LABEL Description="Ruby Base Image"

ENV RUBY_VERSION 2.4.2

# Required for Ruby2
RUN clean_install.sh libyaml-dev

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    cd /tmp && \
    curl -sSL https://get.rvm.io | bash -s stable 
RUN echo 'source /etc/profile.d/rvm.sh' >> /etc/bash.bashrc
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c rvm requirements

# Install Ruby
RUN /bin/bash -l -c 'rvm install $RUBY_VERSION'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION --default'

# Install bundler
RUN /bin/bash -l -c 'gem install bundler'
    
# Cleanup
RUN rm -rf /tmp/* /var/tmp/* /usr/local/src/*
