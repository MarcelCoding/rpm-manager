FROM fedora:latest

RUN dnf install -y findutils rpm-sign createrepo \
    && dnf clean all

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]