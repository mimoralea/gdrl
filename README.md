# Grokking Deep Reinforcement Learning

**Note:** At the moment, only running the code from the [docker](https://github.com/docker/docker-ce) container (below) is supported. Docker allows for creating a single environment that is more likely to work on all systems. Basically, I install and configure all packages for you, except docker itself, and you just run the code on a tested environment. 

To install docker, I recommend a web search for "installing docker on \<your os here>". For running the code on a GPU, you have to additionally install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker). NVIDIA Docker allows for using a host's GPUs inside docker containers. After you have docker (and nvidia-docker if using a GPU) installed, follow the three steps below. 

## Running the code
  1. Pull the gdrl image with: `docker pull mimoralea/gdrl:v0.11`
  2. Spin up a container: `docker run -it --rm -p 8888:8888 -v "$PWD"/notebooks/:/mnt/notebooks/ mimoralea/gdrl:v0.11` (remember to use `nvidia-docker` if you are using a GPU.)
  3. Open a browser and go to the URL shown in the terminal (likely to be: http://localhost:8888). The password is: `gdrl`
