FROM debian:wheezy
MAINTAINER Jean-Christophe Lagache "jclagache@gmail.com"
 
RUN apt-get -q -y update \
	&& apt-get -q -y install wget apt-utils
 
# install puppet:
# https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html
RUN wget -q --no-check-certificate https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb \
	&& dpkg -i puppetlabs-release-wheezy.deb \
	&& rm puppetlabs-release-wheezy.deb \
	&& apt-get -q -y update \
	&& echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
	&& DEBIAN_FRONTEND=noninteractive apt-get -q -y install puppet

# install librarian-puppet
# https://github.com/rodjek/librarian-puppet#how-to-use
RUN apt-get -q -y update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -q -y install git ruby1.9.1-dev make \
	&& gem install librarian-puppet
