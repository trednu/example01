# == Class: sshd
#
# Full description of class sshd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { sshd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class sshd ($ports = [22],
 	    $listen_addresses=['0.0.0.0'], 
	    $UsePrivilegeSeparation = 'yes', 
	    $SyslogFacility = 'LOCAL', 
	    $LogLevel = 'debug',
	    $LoginGraceTime = "",
	    $PermitRootLogin = "yes",
	    $StrictModes = "yes",
	    $RSAAuthentication = "no", 
  	    $PubkeyAuthentication = "no", 
	    $IgnoreRhosts = "",   
	    $RhostsRSAAuthentication = "no",   
	    $HostbasedAuthentication = "no",   
	    $PermitEmptyPasswords = "no",
	    $ChallengeResponseAuthentication = "no",   
	    $PasswordAuthentication = "yes",   
	    $KerberosAuthentication = "yes",  
	    $KerberosGetAFSToken = "",
	    $KerberosOrLocalPasswd = "",
	    $KerberosTicketCleanup = "",    
	    $X11Forwarding = "no",    
	    $X11DisplayOffset = "",   
	    $PrintMotd = "yes",   
	    $PrintLastLog = "no",   
	    $TCPKeepAlive = "yes",    
	    $UseLogin = "no",   
	    $Banner = "",   
	    $UsePAM = "yes",   
	    $MaxAuthTries = "3",   
	    $AllowUsers = "",   
	    $DenyUsers = "",   
) { 

case $::operatingsystem {
        Debian: {
        $packagename = 'sshd'
        $servicename = 'ssh'
        }
	default: {
        $packagename = 'openssh-server'
        $servicename = 'sshd'
        }
}

  package { $packagename: 
	provider => 'apt',
	ensure => 'installed', 
  }

  service { $servicename:
	ensure => 'running',
  }

  file { '/etc/ssh/sshd_config':
	ensure => file, 
	content => template('sshd/sshd_config.erb'), 
	require => Package['sshd'],
  }
}
