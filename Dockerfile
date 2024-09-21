FROM debian:12

RUN apt-get --yes update &&\
  apt-get --yes upgrade &&\
  apt-get --yes install build-essential cmake g++ lsb-release git ninja-build

RUN git clone --branch v9.11 --depth 1 https://github.com/google/or-tools.git &&\
  cd or-tools/ &&\
  cmake -S . -B build/ -G Ninja -DBUILD_DEPS=ON -DCMAKE_BUILD_TYPE=Release &&\
  cmake --build build/ --config Release --verbose --target all &&\
  cmake --build build/ --config Release --verbose --target test &&\
  cmake --build build/ --config Release --verbose --target install &&\
  cd .. &&\
  rm -r or-tools/
