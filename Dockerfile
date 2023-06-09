# Uses binary only
FROM rust:1.67-alpine as builder
RUN apk add --no-cache musl-dev
WORKDIR /usr/src/asciiartify
COPY . .
RUN cargo install --path .

FROM debian:bullseye-slim
COPY --from=builder /usr/local/cargo/bin/asciiartify /usr/local/bin/asciiartify
EXPOSE 8080
CMD ["asciiartify"]
