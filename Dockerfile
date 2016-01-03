FROM haskell:7.8

RUN cabal update

# Add .cabal file
ADD sctty.cabal /opt/server/sctty.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
RUN cd /opt/server && cabal install --only-dependencies -j4

# Add and Install Application Code
ADD . /opt/server
RUN cd /opt/server && cabal install

# Add installed cabal executables to PATH
ENV PATH /root/.cabal/bin:$PATH

# Default Command for Container
WORKDIR /opt/server
CMD ["sctty"]
