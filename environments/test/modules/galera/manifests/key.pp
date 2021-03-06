class galera::key {

  case $operatingsystem {
    
    /^(Debian|Ubuntu)$/ : {
      include apt
      apt::source { 'mariadb':
        location    => 'http://mirror.jmu.edu/pub/mariadb/repo/5.5/ubuntu',
        release     => 'precise',
        repos       => 'main',
        key         => '0xcbcb082a1bb943db',
        key_server  => 'keyserver.ubuntu.com',
        include_src => 'true',
        include_deb => 'true',
      }
    }

    'RedHat','CentOS' : {
      case $architecture {
        'x86_64': {
          yumrepo { 'mariadb':
            name     => 'MariaDB',
            baseurl  => 'http://yum.mariadb.org/10.0/centos7-amd64',
            gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
            gpgcheck => true,
          }
        }
        'i686': {
          yumrepo { 'mariadb':
            name     => 'MariaDB',
            baseurl  => 'http://yum.mariadb.org/10.0/centos7-x86',
            gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
            gpgcheck => true,
          }
        }
      }
    
    }
  }    
}

include galera::key
