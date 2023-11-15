ARG KASPAD_DOCKER_REPO
ARG KASPA_VERSION

FROM $KASPAD_DOCKER_REPO:$KASPA_VERSION AS karlsend

FROM haproxy:lts-alpine

ARG KASPAD_DOCKER_REPO
ARG KASPA_VERSION

EXPOSE 42110
EXPOSE 42111

WORKDIR /app

ENV PATH=/app:$PATH

USER root

COPY --from=karlsend /app/karlsenctl /app/

COPY is-synced.sh /app/
RUN chmod 755 /app/is-synced.sh

COPY haproxy.cfg /app/

USER haproxy

CMD ["/usr/local/sbin/haproxy", "-f", "/app/haproxy.cfg"]

