FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04
MAINTAINER Miguel Morales <mimoralea@gmail.com>
ARG PYTHON_VERSION=3.7
USER root
ENV DEBIAN_FRONTEND noninteractive
ENV MINICONDA_VERSION=4.7.10 \
    MINICONDA_MD5=1c945f2b3335c7b2b15130b1b2dc5cf4 \
    CONDA_VERSION=4.7.12

# update ubuntu installation
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    emacs \
    ffmpeg \
    flex \
    fluidsynth \
    fonts-liberation \
    gifsicle \
    git \
    imagemagick \
    inkscape \
    jed \
    libav-tools \
    libboost-all-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    libsdl2-dev \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    locales \
    nano \
    netcat \
    pandoc \
    python-dev \
    qt-sdk \
    sudo \
    swig \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    unzip \
    vim \
    wget \
    xpra \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER

ADD fix-permissions /usr/local/bin/fix-permissions

# Create jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN groupadd wheel -g 11 && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

USER $NB_UID

# Setup work directory for backward-compatibility
RUN mkdir /home/$NB_USER/work && \
    fix-permissions /home/$NB_USER

# Install conda as jovyan and check the md5 sum provided on the download site
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    echo "${MINICONDA_MD5} *Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh" | md5sum -c - && \
    /bin/bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    echo "conda ${CONDA_VERSION}" >> $CONDA_DIR/conda-meta/pinned && \
    $CONDA_DIR/bin/conda config --system --prepend channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    $CONDA_DIR/bin/conda config --system --set show_channel_urls true && \
    if [ ! $PYTHON_VERSION = 'default' ]; then conda install --yes --quiet python=$PYTHON_VERSION; fi && \
    conda list python | grep '^python ' | tr -s ' ' | cut -d '.' -f 1,2 | sed 's/$/.*/' >> $CONDA_DIR/conda-meta/pinned && \
    $CONDA_DIR/bin/conda install --quiet --yes conda && \
    $CONDA_DIR/bin/conda update --all --quiet --yes && \
    conda clean --all -f -y && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install Tini
RUN conda install --quiet --yes 'tini=0.18.0' && \
    conda list tini | grep tini | tr -s ' ' | cut -d ' ' -f 1,2 >> $CONDA_DIR/conda-meta/pinned && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install Jupyter Notebook, Lab, and Hub
# Generate a notebook server config
# Cleanup temporary files
# Correct permissions
# Do all this in a single RUN command to avoid duplicating all of the
# files across image layers when the permissions change
RUN conda install --quiet --yes \
    'notebook=6.0.0' \
    'jupyterhub=1.0.0' \
    'jupyterlab=1.2.1' && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    jupyter notebook --generate-config && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/
RUN fix-permissions /etc/jupyter/

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Install Python 3 packages
# Remove pyqt and qt pulled in for matplotlib since we're only ever going to
# use notebook-friendly backends in these images
# Install Python 3 packages
RUN conda install --quiet --yes \
    'conda-forge::blas=*=openblas' \
    'beautifulsoup4=4.8.*' \
    'bokeh=1.3*' \
    'cloudpickle=1.2*' \
    'cython=0.29*' \
    'dask=2.3.*' \
    'dill=0.3*' \
    'h5py=2.9*' \
    'hdf5=1.10*' \
    'ipywidgets=7.5*' \
    'matplotlib-base=3.1.*' \
    'numba=0.45*' \
    'numexpr=2.6*' \
    'pandas=0.25*' \
    'patsy=0.5*' \
    'protobuf=3.9.*' \
    'scikit-image=0.15*' \
    'scikit-learn=0.21*' \
    'scipy=1.3*' \
    'seaborn=0.9*' \
    'sqlalchemy=1.3*' \
    'statsmodels=0.10*' \
    'sympy=1.4*' \
    'vincent=0.4.*' \
    'xlrd' \
    && \
    conda clean --all -f -y && \
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    # Also activate ipywidgets extension for JupyterLab
    # Check this URL for most recent compatibilities
    # https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^1.0.1 --no-build && \
    jupyter labextension install jupyterlab_bokeh@1.0.0 --no-build && \
    jupyter lab build && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN npm i -g npm && \
    npm i -g asciicast2gif

# Install facets which does not have a pip or conda package at the moment
RUN cd /tmp && \
    git clone https://github.com/PAIR-code/facets.git && \
    cd facets && \
    jupyter nbextension install facets-dist/ --sys-prefix && \
    cd && \
    rm -rf /tmp/facets && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER

USER $NB_UID

RUN  /opt/conda/bin/conda install -y -q python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing && \
     /opt/conda/bin/conda install -y -q -c pytorch magma-cuda100 && \
     /opt/conda/bin/conda install -y -q -c pytorch pytorch torchvision && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

# jupyter notebook
EXPOSE 8888
# tensorboard
EXPOSE 6006
# switch back to user
USER $NB_USER

# install necessary packages
RUN pip install --upgrade pip && \
  pip install tqdm numpy scikit-learn pyglet setuptools && \
  pip install gym asciinema pandas tabulate tornado==5.* PyBullet && \
  pip install git+https://github.com/pybox2d/pybox2d#egg=Box2D && \
  pip install git+https://github.com/mimoralea/gym-bandits#egg=gym-bandits && \
  pip install git+https://github.com/mimoralea/gym-walk#egg=gym-walk && \
  pip install git+https://github.com/mimoralea/gym-aima#egg=gym-aima && \
  pip install gym[atari]

# create a script to start the notebook with xvfb on the back
# this allows screen display to work well
RUN echo '#!/bin/bash' > /tmp/run.sh && \
  echo "nohup sh -c 'tensorboard --logdir=/mnt/notebooks/logs' > /dev/null 2>&1 &" >> /tmp/run.sh && \
  echo 'find /mnt/notebooks/ -name "*.ipynb" -exec jupyter trust {} \;' >> /tmp/run.sh && \
  echo 'xvfb-run -s "-screen 0 1280x720x24" /usr/local/bin/start-notebook.sh' >> /tmp/run.sh && \
  chmod +x /tmp/run.sh

# move notebooks into container
# ADD notebooks /mnt/notebooks

# make the dir with notebooks the working dir
WORKDIR /mnt/notebooks

# run the script to start the notebook
ENTRYPOINT ["/tmp/run.sh"]

