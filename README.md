# db2

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with db2](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs db2 on Linux.

## Module Description

This module will generate a db2 installer response file, and install db2 on Linux.
It has only been tested with DB2 Express v10 on Centos7.

## Setup

### Beginning with db2

This module expects that the db2 installation source is available to the host. This can be accomplished with any external module for staging binaries.

## Usage

The param 'installer_source_dir' expects to find the folder ./exp.
For example, if "/root" is specified, than this should exist: "/root/exp/db2"

```puppet
class {'db2':
  instance_user_password => 'mypass',
  fenced_user_password   => 'mypass',
  password_salt          => 'random phrase',
  installer_source_dir   => '/root',
}
```

## Reference

Please see the individual manifest files for additional parameters.

## Limitations

This has only been tested with:

+ DB2 Express v10 on Centos 7.
+ DB2 Express v11 on Centos 7.

## Development

This module includes a Vagrantfile for easy testing.
 
Instructions:
 1. Install Vagrant.
 1. Install Virtualbox.
 1. Clone this repo.
 1. Stage the db2 binaries.
 1. Run `vagrant up`.

### Staging the binaries
The db2 installer file must be extracted, and db2setup must reside in `./puppet-db2/vagrant/v10/exp/db2setup`.

The folder structure must look like the following:
```bash
./puppet-db2/vagrant/
./puppet-db2/vagrant/v10/
./puppet-db2/vagrant/v10/exp/
./puppet-db2/vagrant/v10/exp/db2setup
./puppet-db2/Vagrantfile
```
