FROM            fedora
MAINTAINER      Swapnil Kulkarni "coolsvap@gmail.com"

RUN uname -a
RUN yum install git -y
RUN git --version
RUN git clone https://github.com/openstack-dev/devstack.git
RUN git clone https://github.com/coolsvap/fedora-devstack.git
RUN cp fedora-devstack/localrc devstack/localrc
RUN wc -l devstack/localrc
