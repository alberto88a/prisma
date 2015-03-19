include puppet
#
# This module is useless due to puppet master architecture
# include ssh
# Hosts now included by puppet module
# include hosts
#

include user::virtual
include sudoers
include user::sysadmins
include stdlib

node default {}

node galera-master {
  class { 'galera::master':
    nodes_n => hiera('galera_nodes'),
  }
}

node /(galera-)+[0-9]/ {
  class { 'galera::slave':
    nodes_n => hiera('galera_nodes'),
  }
}

node /(haproxy-)+[0-9]/ {
  class { 'haproxy':
    nodes_n  => hiera('galera_nodes'),
  }
  class { 'keepalived':
    haproxy_nodes => hiera('haproxy_nodes'),
  }  
}


node /(rabbit-)+[0-9]/ {
  include rabbit    
}

node gluster-1 {
  include glusterfs::mainserver
}

node /(gluster-)+[2-9]/ {
  include glusterfs::server
}

node gluster-client {
  include glusterfs::client
}

node /(controller-)+[1-9]/ {
  include csync
}

node puppet-agent {

  file { 'agent_test':
    ensure  => present,
    path    => '/root/AGENT_TEST',
    content => 'Puppet Master Working Yo! :-)',
  }

}