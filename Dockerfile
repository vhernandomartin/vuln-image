FROM --platform=linux/amd64 centos:latest
USER 0
ARG OPENAI_API_KEY
RUN echo $OPENAI_API_KEY
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN dnf update -y
RUN dnf groupinstall 'development tools' -y
RUN dnf install wget curl openssl-devel bzip2-devel libffi-devel java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
RUN curl https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz -O && \
    tar -xvf Python-3.9.1.tgz && cd Python-3.9.1 && ./configure --enable-optimizations && make install && \
    python3 -V && \
    python3 -m pip install pip --upgrade && \
    python3 -m pip install openai && \
    python3 -m pip install OpenEXR && \
    python3 -m pip install imath
RUN curl https://download.jboss.org/wildfly/8.0.0.Final/wildfly-8.0.0.Final.tar.gz -O && \
    tar xvf wildfly-8.0.0.Final.tar.gz && mv wildfly-8.0.0.Final /opt/wildfly

EXPOSE 8080
    
ADD myapp/myapp.py /bin/myapp.py
ADD myapp/run.sh /bin/run.sh

CMD /bin/bash /bin/run.sh