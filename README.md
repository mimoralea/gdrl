# Grokking Deep Reinforcement Learning

## Installation instructions
  1. Install "conda" or similar. https://conda.io/docs/user-guide/install/download.html
  2. Create environment with `conda create --name gdrl python=3`
  3. Install packages with `pip install -r requirements.txt`
  4. Start the Notebook, `jupyter notebook`

## Running the code
  1. Download and install `docker` in your machine
  2. Build the gdrl image with: `docker build -t mimoralea/gdrl:v0.2 docker/`
  3. Spin a container: `docker run -it --rm -p 8888:8888 -p 6006:6006 -v $PWD:/mnt/notebooks/ mimoralea/gdrl:v0.2`
  4. Open a browser and go to the URL shown in the console
