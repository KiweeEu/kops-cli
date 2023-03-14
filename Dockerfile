# kiweeteam/kops
FROM ubuntu:22.04
ARG KOPS_VERSION=1.26.2
RUN apt update && apt install -y curl openssh-client
RUN if [ "$(uname -m)" = "aarch64" ]; then \
      curl -sfL https://github.com/kubernetes/kops/releases/download/v${KOPS_VERSION}/kops-linux-arm64 -o /tmp/kops; \
      curl -sfL https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl -o /tmp/kubectl; \
    else \
      curl -sfL https://github.com/kubernetes/kops/releases/download/v${KOPS_VERSION}/kops-linux-amd64 -o /tmp/kops; \
      curl -sfL https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl -o /tmp/kubectl; \
    fi
RUN mv /tmp/kops /usr/bin/kops \
    && chmod +x /usr/bin/kops \
    && mv /tmp/kubectl /usr/bin/kubectl \
    && chmod +x /usr/bin/kubectl
