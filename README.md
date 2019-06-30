# Grokking Deep Reinforcement Learning

**Note:** At the moment, only running the code from the [docker](https://github.com/docker/docker-ce) container (below) is supported. Docker allows for creating a single environment that is more likely to work on all systems. Basically, I install and configure all packages for you, except docker itself, and you just run the code on a tested environment. 

To install docker, I recommend a web search for "installing docker on \<your os here>". For running the code on a GPU, you have to additionally install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker). NVIDIA Docker allows for using a host's GPUs inside docker containers. After you have docker (and nvidia-docker if using a GPU) installed, follow the three steps below. 

## Running the code
  1. Pull the gdrl image with: `docker pull mimoralea/gdrl:v0.11`
  2. Spin up a container: `docker run -it --rm -p 8888:8888 -v "$PWD"/notebooks/:/mnt/notebooks/ mimoralea/gdrl:v0.11` (remember to use `nvidia-docker` if you are using a GPU.)
  3. Open a browser and go to the URL shown in the terminal (likely to be: http://localhost:8888). The password is: `gdrl`

## About the book

### Book's website

https://www.manning.com/books/grokking-deep-reinforcement-learning

### Table of content

  1. Introduction to deep reinforcement learning
  2. [Mathematical foundations of reinforcement learning](/notebooks/chapter_02/chapter-02.ipynb)
  3. [Balancing immediate and long-term goals](/notebooks/chapter_03/chapter-03.ipynb)
  4. [Balancing the gathering and utilization of information](/notebooks/chapter_04/chapter-04.ipynb)
  5. [Estimating agents’ behaviors](/notebooks/chapter_05/chapter-05.ipynb)
  6. [Improving agents’ behaviors](/notebooks/chapter_06/chapter-06.ipynb)
  7. [Achieving goals more effectively and efficiently](/notebooks/chapter_07/chapter-07.ipynb)
  8. [Introduction to value-based deep reinforcement learning](/notebooks/chapter_08/chapter-08.ipynb)
  9. [More stable value-based methods](/notebooks/chapter_09/chapter-09.ipynb)
  10. [Sample-efficient value-based methods](/notebooks/chapter_10/chapter-10.ipynb)
  11. Introduction to policy-based deep reinforcement learning
  12. Parallelizing policy-based methods
  13. Deterministic policy gradient methods
  14. Conservative policy optimization methods
  15. Towards artificial general intelligence
