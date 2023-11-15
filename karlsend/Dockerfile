##
# builder image
##
FROM golang:1.20 as builder

ARG REPO_DIR

COPY "$REPO_DIR" /karlsen

WORKDIR /karlsen

RUN go install -ldflags="-s -w -extldflags=-static" -tags netgo,osusergo . ./cmd/...

##
# karlsend image
##
FROM alpine:latest

ARG REPO_URL
ARG KASPA_VERSION

ENV REPO_URL="$REPO_URL" \
  KASPA_VERSION="$KASPA_VERSION" \
  KASPA_UID=51591 \
  PATH=/app:$PATH

RUN apk --no-cache add \
  libgcc \
  libstdc++ \
  bind-tools \
  dumb-init \
  grep

RUN mkdir -p /app/data/ && \
  addgroup -S -g $KASPA_UID karlsen && \
  adduser -h /app/data -S -D -g '' -G karlsen -u $KASPA_UID karlsen

USER karlsen

COPY ./entrypoint.sh /app/

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 42111 42110
VOLUME /app/data

COPY --from=builder /go/bin/karlsend /go/bin/karlsenctl /app/

CMD ["karlsend", "--utxoindex"]

