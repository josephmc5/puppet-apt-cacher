class apt-cacher($ensure=present) {
    case $operatingsystem {
        centos: { fail('Why would you try to install apt-cacher on centos?') }
        default: { fail('Unrecognized operating system') }
    }
    package { 'apt-cacher':
        ensure => $ensure,
    }
    file {'apt-cacher_default':
        ensure  => present,
        name    => '/etc/default/apt-cacher',
        content => 'AUTOSTART=1',
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        require => Package['apt-cacher'],
        notify  => Service['apt-cacher'],
    }
    service {'apt-cacher':
        ensure => running,
        enable => true,
        hasstatus => false,
    }
}
