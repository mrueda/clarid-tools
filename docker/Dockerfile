FROM ubuntu:22.04

ARG BUILD_VERSION=development
ARG VCS_REF=unknown

LABEL org.opencontainers.image.authors="Manuel Rueda <manuel.rueda@cnag.eu>" \
      org.opencontainers.image.title="ClarID-Tools" \
      org.opencontainers.image.description="Toolkit for generating and validating ClarID identifiers" \
      org.opencontainers.image.source="https://github.com/CNAG-Biomedical-Informatics/clarid-tools" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Artistic-2.0"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
# Ensure that system sbin directories are in PATH
ENV PATH="/usr/local/sbin:/usr/sbin:/sbin:${PATH}"

# Install Linux tools
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
       gcc make cpanminus perl-doc vim sudo libperl-dev qrencode zbar-tools \
       python3 python3-venv \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/share/clarid-tools

# Build from the caller-supplied checkout so release tags are reproducible.
COPY . .
ENV PATH="/opt/clarid-venv/bin:/usr/share/clarid-tools/bin:${PATH}"

RUN cpanm --configure-timeout 300 --notest --installdeps .

# Install Python modules (utils)
RUN python3 -m venv /opt/clarid-venv \
    && pip install --no-cache-dir -r utils/csv/requirements.txt

# Exercise the exact source tree that will remain in the runtime image.
RUN prove -l t \
    && python3 -m unittest discover -s utils/csv -p 'test_*.py' \
    && if [ "$BUILD_VERSION" != "development" ]; then \
         test "$(perl bin/clarid-tools --version)" = "clarid-tools version $BUILD_VERSION"; \
       fi

# Add user "dockeruser"
ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" dockeruser \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" dockeruser

# To change default user from root -> dockeruser
#USER dockeruser
