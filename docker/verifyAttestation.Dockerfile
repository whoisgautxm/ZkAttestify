# To build run: docker build -f Dockerfile.release --build-arg="RISC0_TOOLCHAIN_VERSION=r0.1.79.0-2" -t risczero/risc0-guest-builder:r0.1.79.0-2 .
FROM ubuntu:20.04@sha256:3246518d9735254519e1b2ff35f95686e4a5011c90c85344c1f38df7bae9dd37

ARG RISC0_TOOLCHAIN_VERSION=1.1.1

RUN apt-get update
RUN apt-get install -y --no-install-recommends ca-certificates clang curl libssl-dev pkg-config
RUN curl --proto '=https' --tlsv1.2 --retry 10 --retry-connrefused -fsSL 'https://sh.rustup.rs' | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install cargo-binstall
RUN cargo binstall -y --force cargo-risczero
RUN cargo risczero install --version ${RISC0_TOOLCHAIN_VERSION}
RUN git clone https://github.com/whoisgautxm/ZkAttestifyLocal.git
RUN cargo build

ENTRYPOINT [ "/bin/sh" ]