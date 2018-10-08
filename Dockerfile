FROM jupyter/scipy-notebook
MAINTAINER Miguel Morales <mimoralea@gmail.com>
USER root

# update ubuntu installation
RUN apt update -y
RUN apt install -y --no-install-recommends apt-utils
RUN apt upgrade -y

# install dependencies
RUN apt install -y libav-tools python3 ipython3 python3-pip python3-dev python3-opengl
RUN apt install -y libpq-dev libjpeg-dev libboost-all-dev libsdl2-dev
RUN apt install -y curl cmake swig wget unzip git xpra xvfb flex
RUN apt install -y libav-tools fluidsynth build-essential qt-sdk

# clean up
RUN apt clean && rm -rf /var/lib/apt/lists/*

# jupyter notebook
EXPOSE 8888

# tensorboard
EXPOSE 6006

# switch back to user
USER $NB_USER

RUN conda install --yes \
	pytorch torchvision -c pytorch

# install necessary packages
RUN pip install --upgrade pip
RUN pip install numpy scikit-learn pyglet setuptools \
	gym asciinema pandas

# create a script to start the notebook with xvfb on the back
# this allows screen display to work well
RUN echo '#!/bin/bash' > /tmp/run.sh && \
    echo "nohup sh -c 'tensorboard --logdir=/mnt/notebooks/logs' > /dev/null 2>&1 &" >> /tmp/run.sh && \
    echo 'xvfb-run -s "-screen 0 1280x720x24" /usr/local/bin/start-notebook.sh' >> /tmp/run.sh && \
    chmod +x /tmp/run.sh

# move notebooks into container
# ADD notebooks /mnt/notebooks

# make the dir with notebooks the working dir
WORKDIR /mnt/notebooks

# run the script to start the notebook
ENTRYPOINT ["/tmp/run.sh"]
