## Docker Dev Environment

Build
`docker build -f Dockerfile.python --build-arg uid=$UID --build-arg gid=$UID --build-arg usr=$USER -t pydev .`

Run
`docker run -it --rm --net="host" -v $PWD:/src -v home:/home/dev pydev`
