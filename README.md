# activeMQ-deb-packaging
===================

Simple debian packaging for Apache ActiveMQ

### Changelog


# Pre-requisites - Install fpm

```sh
$ sudo apt-get update
$ sudo apt-get install ruby-dev build-essential
$ sudo gem install fpm
```
# Options

You can change the ActiveMQ version in dist_activemq on new versions of both.

# Usage

```sh
$ ./dist_activemq.sh
```

# Installation

```sh
$ dpkg -i activemq_5.13.0-1_all.deb
```

or if you have your own repo:

```sh
$ ~/gpg-agent-headless.sh
$ reprepro -b /var/repositories/ includedeb trusty $@
$ apt-get install activemq
```
Note: Installs and runs as user 'activemq'. Easy to change for your needs.

## Post install

```sh

$ sudo update-rc.d activemq defaults 25

 Adding system startup for /etc/init.d/activemq ...
   /etc/rc0.d/K25activemq -> ../init.d/activemq
   /etc/rc1.d/K25activemq -> ../init.d/activemq
   /etc/rc6.d/K25activemq -> ../init.d/activemq
   /etc/rc2.d/S25activemq -> ../init.d/activemq
   /etc/rc3.d/S25activemq -> ../init.d/activemq
   /etc/rc4.d/S25activemq -> ../init.d/activemq
   /etc/rc5.d/S25activemq -> ../init.d/activemq
```

## Tested Platforms

* Debian Wheezy

---

## Package info
Debian pkg: `activemq_5.13.0-1_all.deb`
Version :
  - ActiveMQ 5.13.0

Init scripts:
  - /etc/init.d/activemq

Configuration:
  - /etc/activemq
  - /etc/default/activemq

Logs:
  - /var/log/activemq/

Binaries:
  - /usr/local/activemq/bin/

Data:
  - /var/lib/activemq/

Network ports:
  -

Users:
  - activemq : activemq

---
