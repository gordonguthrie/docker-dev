FROM elixir:1.19.5

USER root

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y make
RUN apt-get install -y unzip
RUN apt-get install -y lynx
RUN apt-get install -y emacs
RUN apt-get install -y wget
RUN apt-get install -y sudo
RUN apt-get install -y lsof
RUN apt-get install -y net-tools
RUN apt-get install -y x11-apps
RUN apt-get install -y tree
RUN apt-get install -y libssl-dev
RUN apt-get install -y build-essential

# Pre-warm the rebar3 pc (port_compiler) plugin cache so NIF compilation
# works offline at runtime.
RUN mkdir -p /tmp/warm_pc/src && \
    echo '{plugins, [pc]}.' > /tmp/warm_pc/rebar.config && \
    cd /tmp/warm_pc && rebar3 compile; \
    rm -rf /tmp/warm_pc

# Replace 1000 with your user / group id
RUN export uid=501 gid=20 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    mkdir /home/developer/.mix && \
    chown ${uid}:${gid} -R /home/developer/.mix
RUN usermod -aG sudo developer

RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.8.7 --force
RUN mix local.rebar --force

# Write an entrypoint that injects test hostnames into /etc/hosts at runtime,
# then hands off to the CMD.  /etc/hosts is a bind-mount so it can only be
# written at container start, not during image build.
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/bin/bash"]
CMD ["tail", "-f", "/dev/null"]
