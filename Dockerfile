FROM tsl0922/ttyd:latest AS ttyd
ARG TARGETPLATFORM
ARG KUBECTL_VERSION="v1.29.0"

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    apt-transport-https \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*


# linux/amd64, linux/arm64, linux/x86_64,linux/arm64/v8
# Install k9s
RUN case ${TARGETPLATFORM} in \
        "linux/amd64")  K9S_ARCH=amd64  ;; \
        "linux/arm64")  K9S_ARCH=arm64  ;; \
    esac \ 
    && wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_${K9S_ARCH}.tar.gz \
    && tar -xzf k9s_Linux_${K9S_ARCH}.tar.gz \    
    && mv k9s /usr/local/bin/ \
    && rm k9s_Linux_${K9S_ARCH}.tar.gz

# Install kubectl
RUN TARGET_ARCH=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGET_ARCH}/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl 

# Create .kube directory
RUN mkdir -p /root/.kube
# Set working directory
WORKDIR /root
# Start ttyd with k9s
CMD ["ttyd", "--writable", "k9s"]