description "My cool stuff"
author      "Kun Li"

start on (local-filesystems and net-device-up and runlevel [2345])
stop on runlevel [!2345]

respawn
respawn limit 10 5

script
    setuid username
    chdir /var/www/
    exec /usr/local/bin/myserver --port 8080
end script

post-start script
    # Optionally put a script here that will notify you server has (re)started
end script
