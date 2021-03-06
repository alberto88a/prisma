class galera::slave ( $nodes_n ) {

  anchor { 'galera::begin': }                      			->
    class { 'galera::key': }                       			-> 
    class { 'galera::dependencies': }              			-> 
    class { 'galera::clusterconfig': nodes_n => $nodes_n }             	-> 
    class { 'galera::exec::slave': }              		        -> 
  anchor { 'galera::end': }  
          
}

include galera::slave
