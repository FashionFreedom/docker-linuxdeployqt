FROM ubuntu:16.04

# required by linuxdeployqt
#   fuse, binutils (objdump), libglib2.0-0
RUN apt update && \
      apt install --assume-yes python3-pip wget fuse binutils libglib2.0-0 && \
    pip3 install aqtinstall

RUN aqt install 5.9.5 linux desktop -m all && cp -R ./5.9.5/gcc_64/* /usr && rm -rf ./5.9.5

RUN apt install --assume-yes libgl1-mesa-glx libfontconfig1 libxi6 libdbus-1-3 libxcb-xfixes0 libegl1-mesa libcups2

ENV QT_SELECT=5

RUN wget https://github.com/probonopd/linuxdeployqt/releases/download/6/linuxdeployqt-6-x86_64.AppImage \
      --quiet --output-document=/usr/bin/linuxdeployqt && \
    chmod +x /usr/bin/linuxdeployqt

COPY builder.sh .
CMD ./builder.sh