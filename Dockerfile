FROM multiarch/qemu-user-static:x86_64-mips64el as qemu
FROM aoqi/debian-mips64el
COPY --from=qemu /usr/bin/qemu-mips64el-static /usr/bin

RUN set -eu; \
    apt-get update && apt-get install -y --no-install-recommends \
    axel \
    cpio \
    sudo \
    gdbserver \
    lsb-release \
    openssh-server \
    build-essential \
    git \
    cmake \
    nano \
    python3-pip \
    libssl-dev;

# Enable remote debugging
RUN set -eu; \
    mkdir /var/run/sshd; \
    echo 'root:root' | chpasswd; \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd;

# 22 for ssh server, 7777 for gdb server
EXPOSE 22 7777

RUN set -eux; \
    $(which python3); \
    ln -sf $(which python3) /usr/bin/python; \
    ln -sf $(which pip3) /usr/bin/pip;

RUN apt-get install -y python3-setuptools

RUN pip install --upgrade pip && pip install --no-cache-dir conan

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

CMD bash
