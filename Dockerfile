FROM quay.io/argoproj/argocd:v2.1.2

# Switch to root for the ability to perform install
USER root
RUN apt-get update && \
    apt-get install -y \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Switch back to non-root user
USER 999

ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"

# Install helm-s3 tool
ARG GCS_PLUGIN_VERSION="0.10.0"
ARG GCS_PLUGIN_REPO="https://github.com/hypnoglow/helm-s3.git"

RUN helm plugin install ${GCS_PLUGIN_REPO} --version ${GCS_PLUGIN_VERSION}

