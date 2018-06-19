class docker{
case$::osfamily{
"redhat":{ 
$docker = ["yum-utils","device-mapper-persistent-data","lvm2","docker-ce"]
}
"debian":{
docker = [install,"apt-transport-https","ca-certificates","curl","software-properties-common"]
}
}
}
package{$docker: 
ensure => present
}

osfamily{
"debian"= {
exec{
command => "usr/bin/curl -fsSLui https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
}
package{"docker-ce"
ensure => present
enable => true
}
}
}
