FROM debian:wheezy
MAINTAINER Jean-Christophe Lagache "jclagache@gmail.com"
 
# Prerequis
# http://askubuntu.com/questions/365911/why-the-services-do-not-start-at-installation
RUN apt-get -q -y update \
	&& apt-get -q -y install apt-utils \
	&& echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Install the Puppetlabs GPG key
RUN apt-key adv --recv-key --keyserver pool.sks-keyservers.net 4BD6EC30

# Add the Puppetlabs APT repository to our APT sources
RUN /bin/echo -e "# Puppetlabs products\ndeb http://apt.puppetlabs.com wheezy main\ndeb-src http://apt.puppetlabs.com wheezy main\n\n# Puppetlabs dependencies\ndeb http://apt.puppetlabs.com wheezy dependencies\ndeb-src http://apt.puppetlabs.com wheezy dependencies\n\n# Puppetlabs devel (uncomment to activate)\n# deb http://apt.puppetlabs.com wheezy devel\n# deb-src http://apt.puppetlabs.com wheezy devel" > /etc/apt/sources.list.d/puppetlabs.list \
	&& apt-get -q -y update

# Install puppet
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install puppet

# install librarian-puppet
# https://github.com/rodjek/librarian-puppet#how-to-use
RUN apt-get -q -y update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -q -y install git ruby1.9.1-dev make \
	&& gem install --no-rdoc --no-ri librarian-puppet
