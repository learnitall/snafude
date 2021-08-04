FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies.
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    git \
    ca-certificates \
    libffi-dev \
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    iputils-ping \
    pandoc \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -f /var/cache/apt/archives/*.deb

# Create snafu user
RUN useradd --user-group --uid 1337 --create-home --shell /bin/bash snafu
USER snafu

# Install pyenv
RUN git clone https://github.com/pyenv/pyenv /home/snafu/.pyenv

# Install the desired versions of Python.
RUN for PYTHON_VERSION in 3.6.13 3.7.10 3.8.10 3.9.6; do \
  set -ex \
    && /home/snafu/.pyenv/bin/pyenv install ${PYTHON_VERSION} \
    && /home/snafu/.pyenv/versions/${PYTHON_VERSION}/bin/python -m pip install --upgrade pip \
  ; done

# Install tox for 3.9
RUN /home/snafu/.pyenv/versions/3.9.5/bin/python -m pip install tox

# Add to PATH, in order of lowest precedence to highest.
ENV PATH /home/snafu/.pyenv/versions/3.6.13/bin:${PATH}
ENV PATH /home/snafu/.pyenv/versions/3.7.10/bin:${PATH}
ENV PATH /home/snafu/.pyenv/versions/3.8.10/bin:${PATH}
ENV PATH /home/snafu/.pyenv/versions/3.9.5/bin:${PATH}

VOLUME ["/home/snafu/snafu"]
WORKDIR /home/snafu/snafu
CMD ["python3.9", "-m", "tox"]
