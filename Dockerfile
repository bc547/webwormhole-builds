# syntax=docker/dockerfile:1.7

ARG GO_IMAGE=golang:1.24-bookworm
ARG UPSTREAM_REPOSITORY=https://github.com/saljam/webwormhole.git
ARG UPSTREAM_REF=master

FROM ${GO_IMAGE} AS source

ARG UPSTREAM_REPOSITORY
ARG UPSTREAM_REF

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git clone \
      --filter=blob:none \
      --no-checkout \
      "${UPSTREAM_REPOSITORY}" . \
    && git checkout --detach "${UPSTREAM_REF}" \
    && git rev-parse HEAD > /SOURCE_COMMIT

RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download


FROM source AS build

ENV CGO_ENABLED=0

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    set -eu; \
    mkdir -p /out; \
    build_one() { \
        goos="$1"; \
        goarch="$2"; \
        filename="$3"; \
        shift 3; \
        echo "Building ${filename} for ${goos}/${goarch}"; \
        env \
          GOOS="${goos}" \
          GOARCH="${goarch}" \
          "$@" \
          go build \
            -trimpath \
            -buildvcs=false \
            -ldflags="-s -w -buildid=" \
            -o "/out/${filename}" \
            ./cmd/ww; \
    }; \
    build_one windows amd64 ww-windows-amd64.exe GOAMD64=v1; \
    build_one linux amd64 ww-linux-amd64 GOAMD64=v1; \
    build_one linux arm64 ww-linux-arm64-rpi GOARM64=v8.0; \
    build_one linux riscv64 ww-linux-riscv64; \
    cp /SOURCE_COMMIT /out/SOURCE_COMMIT; \
    cp LICENSE /out/LICENSE-webwormhole; \
    cd /out; \
    sha256sum ww-* > SHA256SUMS


FROM scratch AS artifacts

COPY --from=build /out/ /
