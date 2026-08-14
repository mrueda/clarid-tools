<p align="center">
  <a href="https://github.com/cnag-biomedical-informatics/clarid-tools"><img src="docs-site/static/img/clarid-logo.png" width="300" alt="ClarID-Tools"></a>
</p>
<p align="center">
    <em>ClarID: A Human-Readable and Compact Identifier Specification for Biomedical Metadata Integration</em>
</p>

[![Build and Test](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/build-and-test.yml)
[![Coverage Status](https://coveralls.io/repos/github/CNAG-Biomedical-Informatics/clarid-tools/badge.svg?branch=main)](https://coveralls.io/github/CNAG-Biomedical-Informatics/clarid-tools?branch=main)
[![CPAN Publish](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/cpan-publish.yml/badge.svg)](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/cpan-publish.yml)
[![Kwalitee Score](https://cpants.cpanauthors.org/dist/ClarID-Tools.svg)](https://cpants.cpanauthors.org/dist/ClarID-Tools)
![version](https://img.shields.io/badge/version-0.04-28a745)
[![Docker Build](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/docker-build-multi-arch.yml/badge.svg)](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/docker-build-multi-arch.yml)
[![Docker Pulls](https://badgen.net/docker/pulls/manuelrueda/clarid-tools?icon=docker&label=pulls)](https://hub.docker.com/r/manuelrueda/clarid-tools/)
[![Docker Image Size](https://badgen.net/docker/size/manuelrueda/clarid-tools?icon=docker&label=image%20size)](https://hub.docker.com/r/manuelrueda/clarid-tools/)
[![Documentation Status](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/documentation.yml/badge.svg)](https://github.com/cnag-biomedical-informatics/clarid-tools/actions/workflows/documentation.yml)
[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)
[![Google Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1smS42yzL7qYV1kCz34baTWLRr_AAap-r)

---

**📘 Documentation:** <a href="https://cnag-biomedical-informatics.github.io/clarid-tools" target="_blank">https://cnag-biomedical-informatics.github.io/clarid-tools</a>

**📓 Google Colab tutorial:** <a href="https://colab.research.google.com/drive/1smS42yzL7qYV1kCz34baTWLRr_AAap-r" target="_blank">https://colab.research.google.com/drive/1smS42yzL7qYV1kCz34baTWLRr_AAap-r</a>

**🗂️  Use Cases I & II GDC Data:** <a href="https://github.com/CNAG-Biomedical-Informatics/clarid-tools/tree/main/nb/data" target="_blank">https://github.com/CNAG-Biomedical-Informatics/clarid-tools/tree/main/nb/data</a>

**📦 CPAN Distribution:** <a href="https://metacpan.org/pod/ClarID::Tools" target="_blank">https://metacpan.org/pod/ClarID::Tools</a>

**🐳 Docker Hub Image:** <a href="https://hub.docker.com/r/manuelrueda/clarid-tools/tags" target="_blank">https://hub.docker.com/r/manuelrueda/clarid-tools/tags</a>

---

# ClarID-Tools

<!--description-start-->

## 📝 Description

**ClarID-Tools** is a toolkit for working with the **ClarID** specification, including the reference command-line implementation, preprocessing utilities, and example workflows. The objective is to standardize how subject and biosample metadata are transformed into compact, informative IDs for downstream integration, tracking, and exchange.

---

## 🔬 Key Features

- 🧬 **Biosample and Subject ID generation** from structured metadata
- 🩺 **Support for clinical and experimental metadata**, including species, tissue, assay, condition, and more
- 📄 **Human-readable and stub-formatted modes** for compact or verbose identifiers
- 🧪 **Bulk and single-record encoding/decoding**
- ✅ **Schema validation** using JSON Schema and YAML codebooks
- 📦 Command-line interface 

---

<!--description-end-->

## 🚀 Getting Started

### 🛠️  Installation

We offer two modes of installation:

1. [Non-Containerized](non-containerized/README.md)


2. [Containerized](docker/README.md)


### ▶️ Running the CLI

- If you cloned this repository, run commands from the repository root with `bin/clarid-tools`.
- If you installed ClarID-Tools with CPAN or system-wide, run `clarid-tools`.
- The packaged default codebook is used automatically, so `--codebook` is only needed when you want to use a custom codebook.
- The `qrcode` subcommand requires `qrencode` and `zbarimg` on host installs. The Docker image already includes them.

### 📘 Example Usage

1. [Quickstart](https://cnag-biomedical-informatics.github.io/clarid-tools/usage/quickstart/)

2. Use Cases:
 
  * [Biosample](https://cnag-biomedical-informatics.github.io/clarid-tools/use-cases/biosample/)
  * [Subject](https://cnag-biomedical-informatics.github.io/clarid-tools/use-cases/subject/)

---

## 🧠 Citation

If you use **ClarID-Tools** in your work, please cite:

Rueda, M. and Gut, I.G. (2026). ClarID: a human-readable and compact identifier specification for biomedical metadata integration. _Journal of Biomedical Semantics_ 17, 9. https://doi.org/10.1186/s13326-026-00349-6

---


## 👤 Author 

Written by Manuel Rueda, PhD. Info about CNAG can be found at [https://www.cnag.eu](https://www.cnag.eu).

---


## 📄 License

ClarID-Tools is released under the Artistic License. See the [LICENSE](LICENSE) file for details.
