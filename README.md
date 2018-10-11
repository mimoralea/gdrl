# Grokking Deep Reinforcement Learning

**Note:** At the moment, only running the code from the [docker](https://github.com/docker/docker-ce) container (below) is supported. Docker allows for creating a single environment that is more likely to work on all system. Basically, I install and configure all packages for you, except docker itself. To install docker, I recommend a web search for "installing docker on <you os here>". For running the code on a GPU, you have to additionally install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker). NVIDIA Docker allows for using a host's GPUs inside docker containers. After you have docker (and nvidia-docker if using a GPU) installed, follow the steps below. 

## Running the code
  1. Build the gdrl image with: `docker build -t mimoralea/gdrl:v0.2 docker/`
  2. Spin up a container: `docker run -it --rm -p 8888:8888 -p 6006:6006 -v $PWD:/mnt/notebooks/ mimoralea/gdrl:v0.2`
  3. Open a browser and go to the URL shown in the console
