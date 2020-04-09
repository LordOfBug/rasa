# Create common base stage
FROM centos:7 as base

#FROM centos/python-36-centos7 as base
# Chinese support
RUN rm -rf /etc/localtime  && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && \
    yum -y install kde-l10n-Chinese  && \
    yum -y reinstall glibc-common  && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8  && \
    yum clean all  &&  rm -rf /var/cache/yum

ENV LC_ALL zh_CN.utf8

# Install Python 3.6
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y install python36u && \
    yum -y install python36u-pip && \
    yum -y install vim && \
    yum clean all  &&  rm -rf /var/cache/yum

# COPY pip.conf
COPY pip.conf /etc/pip.conf

# Make sure we have the latest pip version
RUN python3.6 -m pip install -U pip

RUN python3.6 -m pip --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        scipy==0.18.1 \
        sklearn \
        && \
    python3.6 -m ipykernel.kernelspec

WORKDIR /build

# Create virtualenv to isolate builds
# RUN python3.6 -m venv /build   # disable this as it would get the version wrong!!!

# Install common libraries
RUN yum update -y

# required by psycopg2 at build and runtime
RUN yum install -y libpqxx-devel 
    
# required for health check
RUN yum install -y curl

RUN yum autoremove -y

# Make sure we use the virtualenv
ENV PATH="/build/bin:$PATH"

# Stage to build and install everything
FROM base as builder

WORKDIR /src

# Install all required build libraries
RUN yum check-update -q \
 && yum install -y \
    build-essential \
    wget \
    openssh-client \
    gcc \
    gcc-c++ \
    python3-devel \
    graphviz-devel \
    pkg-config \
    git-core \
    openssl \
    openssl-devel \
    libffi \
    libffi-devel \
    libpng-devel

# Download mitie model
# RUN wget -P /app/data/ https://s3-eu-west-1.amazonaws.com/mitie/total_word_feature_extractor.dat

# COPY mitie model
COPY data/total_word_feature_extractor.dat /app/data/

# COPY spacy models
COPY data/en_core_web_md-2.1.0.tar.gz /app/data/
COPY data/de_core_news_sm-2.1.0.tar.gz /app/data/

# Copy only what we really need
COPY README.md .
COPY setup.py .
COPY setup.cfg .
COPY MANIFEST.in .
COPY alt_requirements/ ./alt_requirements
COPY requirements.txt .
COPY LICENSE.txt .

# Install dependencies
RUN python3.6 -m pip -V
RUN python3.6 -m pip install --no-cache-dir -r alt_requirements/requirements_full.txt

# Install and link spacy models
# RUN pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_md-2.1.0/en_core_web_md-2.1.0.tar.gz#egg=en_core_web_md==2.1.0 --no-cache-dir > /dev/null \
#  && python -m spacy link en_core_web_md en \
#  && pip install https://github.com/explosion/spacy-models/releases/download/de_core_news_sm-2.1.0/de_core_news_sm-2.1.0.tar.gz#egg=de_core_news_sm==2.1.0 --no-cache-dir > /dev/null \
#  && python -m spacy link de_core_news_sm de
RUN python3.6 -m pip install /app/data/en_core_web_md-2.1.0.tar.gz > /dev/null
RUN python3.6 -m spacy link en_core_web_md en
RUN python3.6 -m pip install /app/data/de_core_news_sm-2.1.0.tar.gz > /dev/null
RUN python3.6 -m spacy link de_core_news_sm de

# Install Rasa as package
COPY rasa ./rasa
RUN python3.6 -m pip install .[sql,spacy,mitie]

# Runtime stage which uses the virtualenv which we built in the previous stage
FROM base AS runner

WORKDIR /app

# Copy over default pipeline config
COPY sample_configs/config_pretrained_embeddings_spacy_duckling.yml config.yml

# Copy over mitie model
COPY --from=builder /app/data/total_word_feature_extractor.dat data/total_word_feature_extractor.dat

# Copy virtualenv from previous stage
COPY --from=builder /build /build

# Create a volume for temporary data
VOLUME /tmp

# Make sure the default group has the same permissions as the owner
RUN chgrp -R 0 . && chmod -R g=u .

# Don't run as root
USER 1001

EXPOSE 5005

ENTRYPOINT ["rasa"]
CMD ["--help"]
