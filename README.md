## Docker Dev Environment

Build
`docker build --build-arg UID=$UID --build-arg GID=$UID -t docker-dev .`

Run
```
dev()
{
    if [[ $(docker ps -qf "name=docker-dev") ]];
    then
      docker exec -it -w ${PWD#$HOME} docker-dev /bin/ash --login
    else
      docker run -it --rm -d --net="host" -h docker-dev -v ~/src:/src -v home:/home/dev -w ${PWD#$HOME} --name docker-dev docker-dev && dev
    fi
}
```
