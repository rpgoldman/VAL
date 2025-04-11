FROM python:3.12-bookworm

RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  # install cmake
  cmake \
  # install make g++
  make g++ \
  # install clang-format
  clang-format \
  # install doxygen
  doxygen \
  graphviz \
  # install zip
  zip unzip \
  && \
  apt-get clean && \
  rm /var/lib/apt/lists/*_*

RUN mkdir -p /usr/local/src

ENV SRCDIR=/usr/local/src/VAL

COPY . $SRCDIR

RUN cd $SRCDIR && cd scripts/linux && ./clean.sh && ./build_linux64.sh all Release
RUN cp ${SRCDIR}/build/linux64/Release/install/bin/* /usr/local/bin/