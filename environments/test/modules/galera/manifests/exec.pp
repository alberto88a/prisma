class galera::exec::master {
  if $osfamily == "RedHat" {
    exec { "enforcing mode":
      command => "setenforce 0",
      path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#      notify  => Service['firewalld'],
    }
#    service { 'firewalld':
#      provider => systemd,
#      enable   => true,
#      ensure   => running,
#    }
    file { 'firewall-cmd':
      ensure  => 'file',
      source  => 'puppet:///modules/galera/firewall-cmd.sh',
      path    => '/usr/local/bin/firewall-cmd.sh',
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      notify  => Exec['firewall-cmd'],
    }
    exec { 'firewall-cmd':
      command     => '/usr/local/bin/firewall-cmd.sh',
      refreshonly => true,
    }
  }
   
  exec { "start galera cluster":
    command => "service mysql start --wsrep-new-cluster",
    path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }
  
  class { 'database':
    require => Exec["start galera cluster"],
  }
}

class galera::exec::slave {
  if $osfamily == "RedHat" {
    exec { "enforcing mode":
      command => "setenforce 0",
      path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#      notify  => Service['firewalld'],
    }
#    service { 'firewalld':
#      enable   => true,
#      ensure   => running,
#      provider => systemd,
#    }
    file { 'firewall-cmd':
      ensure  => 'file',
      source  => 'puppet:///modules/galera/firewall-cmd.sh',
      path    => '/usr/local/bin/firewall-cmd.sh',
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      notify  => Exec['firewall-cmd'],
    }
    exec { 'firewall-cmd':
      command     => '/usr/local/bin/firewall-cmd.sh',
      refreshonly => true,
    }
  }
  
  exec { "participate galera cluster":
    command => "service mysql start",
    path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }
} 


