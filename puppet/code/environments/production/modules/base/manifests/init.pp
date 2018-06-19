class base {
	case$::osfamily{
		"redhat":{
			$pacotes = ["fish","epel-release","git","vim","sysstat","htop","sl","figlet"]
		
			$web = "httpd"
			}
		"debian":{
			$pacotes = ["fish","git","vim","sysstat","htop","cowsay","sl","figlet"]
				exec{"Atualiza Repos":
					command => "/usr/bin/apt update"
	
		}

			$web = "apache2"				
		}
	}
}
	package{$pacotes:
		ensure => present
	}

	file{'/root/.bashrc':
		source => "puppet:///modules/base/bashrc_base",
		       ensure => present
	}
	user{'devops':
		ensure => present,
		       managehome => yes,
		       shell => "/usr/bin/fish"
	}

	service{"nginx":
		ensure => stopped,
		enable => false
	}

	service{'$web':
		ensure => running,
		enable => true
	}

