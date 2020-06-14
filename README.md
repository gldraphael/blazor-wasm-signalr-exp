# Blazor + WebAssembly + SignalR Experiment

![ci](https://github.com/gldraphael/blazor-wasm-signalr-exp/workflows/ci/badge.svg)

## Quickstart

### Running a per-built docker image locally

1. Open up your terminal, and run:

    ```sh
    docker run --rm -p 6789:80 gldraphael/blazor-wasm-signalr-exp
    ```
1. Browse to `http://localhost:6789`.

### Building and running the sample locally within docker

```sh
git clone git@github.com:gldraphael/blazor-wasm-signalr-exp.git
cd blazor-wasm-signalr-exp
docker-compose build
docker-compose up
```
