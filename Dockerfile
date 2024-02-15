FROM alpine:latest

ENV K8S_VERSION=v1.26.13
ENV HELM_VERSION=v3.14.0
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV WERF_VERSION=1.2.292

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip git \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://get.helm.sh/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && curl -L https://tuf.werf.io/targets/releases/${WERF_VERSION}/linux-amd64/bin/werf -o /usr/local/bin/werf \
 && chmod +x /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/werf \
 && apk del --purge deps \
 && rm /var/cache/apk/*

CMD ["helm"]
