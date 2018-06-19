class docker {
        case $::osfamily {
		"debian":{
			exec{'Atualizar o repo': command => "/user/bin/apt update"}

			$distro_name = $facts['os']['distro']['codename']
			$pacotes = ['apt-transport-https', 'ca-certificates','curl','software-properties-common']
			$repositorio = "/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | /usr/bin/apt-key add - ; /usr/bin/add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $distro_name stable' ; /usr/bin/apt update"
		}

		"redhat":{
			$pacotes = ['yum-utils','device-mapper-persistent-data', 'lvm2']
			$repositorio = "/bin/yum-cofnig-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
		}
        }

	package{$pacotes:
		ensure => present
	}

	exec{'Adicionando repo':
		command => $repositorio
	}

	package{'docker-ce':
		 ensure => present
	}

	service{'docker':
		ensure => running,
		enable => true,
		require => Package['docker-ce']
	}
}

