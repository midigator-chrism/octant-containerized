FROM --platform=linux/amd64 alpine:latest

WORKDIR /tmp

RUN wget -O octant.tgz https://github.com/vmware-tanzu/octant/releases/download/v0.25.1/octant_0.25.1_Linux-64bit.tar.gz && \
    tar xzf octant.tgz && \
    mv octant_0.25.1_Linux-64bit/octant /usr/local/bin/ && \
    chown root:root /usr/local/bin/octant && \
    chmod 0755 /usr/local/bin/octant && \
    rm -rf /tmp/octant* && \ 
    wget -O /usr/local/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64 && \
    chown root:root /usr/local/bin/aws-iam-authenticator && \
    chmod 0755 /usr/local/bin/aws-iam-authenticator && \
    addgroup octant && adduser octant -G octant -D

USER octant

WORKDIR /home/octant

RUN mkdir -p .config/octant/plugins

ENV OCTANT_LISTENER_ADDR=0.0.0.0:80

EXPOSE 80

ENTRYPOINT [ "/usr/local/bin/octant", "--disable-open-browser" ]
