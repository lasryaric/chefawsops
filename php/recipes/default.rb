php5_root = "/etc/php5/"

packages = [
    'php5',
    'php5-cli',
    'php5-mysql',
    'libapache2-mod-php5',
    'php5-curl',
    'php5-dev',
    'php-pear',
    'php5-gd',
    'php-apc',
    'php5-mcrypt']

pear_pagackes = ['mongo-1.2.10', 'xdebug']

ini_files = ['xdebug.ini', 'timezone.ini', 'apc.ini', 'error.ini', 'mongo.ini', 'mbstring.ini']

pear_channels = ['pear.phpunit.de', 'components.ez.no', 'pear.symfony.com']

for package in packages
    package "#{package}"
end


for pear_package in pear_pagackes
    execute "pecl install #{pear_package}" do
        command "pecl install #{pear_package}"
        not_if "pecl list | grep mongo"
    end
end


for ini_file in ini_files
    cookbook_file "#{php5_root}/conf.d/#{ini_file}" do
        source "#{ini_file}"
        action :create
    end
end

for pear_channel in pear_channels
    execute "pear channel-discover #{pear_channel}" do
        command "pear channel-discover #{pear_channel}"
        not_if "pear list-channels  | grep #{pear_channel}"
    end
end

    # command => "pear install --alldeps phpunit/PHPUnit",
    # unless => "test -f /usr/bin/phpunit",

execute "pear install --alldeps phpunit/PHPUnit" do
    command "pear install --alldeps phpunit/PHPUnit"
    not_if "test -f /usr/bin/phpunit"
end
