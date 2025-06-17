FROM alpine:latest

ENV K8S_VERSION=v1.32.5
ENV HELM_VERSION=v3.12.2
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV WERF_VERSION=2.37.1

# Minimal runtime dependencies (no bash, no gettext)
RUN apk add --no-cache \
    ca-certificates \  
    curl \  
    tar \  
    git \  
    coreutils \  
    busybox-extras \  
    && \
    # Install kubectl, helm, werf
    curl -Lo /usr/local/bin/kubectl \
        "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl" \
    && curl -L "https://get.helm.sh/${HELM_FILENAME}" | tar xz \
        && mv linux-amd64/helm /usr/local/bin/helm \
        && rm -rf linux-amd64 \
    && curl -Lo /usr/local/bin/werf \
        "https://tuf.werf.io/targets/releases/${WERF_VERSION}/linux-amd64/bin/werf" \
    && chmod +x /usr/local/bin/kubectl /usr/local/bin/helm /usr/local/bin/werf

# Use minimal shell (no bash)
ENTRYPOINT ["/bin/sh"]
CMD ["helm"]



