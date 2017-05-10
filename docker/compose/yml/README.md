
## Symlink to Docker-Compose configuration
In order to keep all config files in one place, we've put the compose config file in the `/mapic/config/[example.domain.com]/` folder. 

In order to find the Compose configuration file, we need to create a symlink pointing to the `config` folder:
```bash
# create symlink to Docker-Compose config file
# replace example.domain.com with your domain
ln -l example.domain.com.yml -> ../../../config/example.domain.com/example.domain.com.yml
```

`/mapic/docker/compose/yml/` folder should read:

```bash
total 16K
drwxr-xr-x 2 root root 4.0K May 10 13:50 ./
drwxr-xr-x 3 root root 4.0K May  5 13:44 ../
-rw-r--r-- 1 root root  887 May  5 12:54 common.yml
-rw-r--r-- 1 root root 2.2K May  5 12:54 localhost.yml
lrwxrwxrwx 1 root root   53 May 10 13:44 example.domain.com.yml -> ../../../config/example.domain.com/example.domain.com.yml
```