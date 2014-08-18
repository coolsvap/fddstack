FROM            coolsvap/fddstack
MAINTAINER      Swapnil Kulkarni "coolsvap@gmail.com"

RUN uname -a
RUN whoami
RUN yum install git -y
RUN git --version
RUN rm -rf devstack ubuntu-devstack
RUN git clone https://github.com/openstack-dev/devstack.git
RUN git clone https://github.com/coolsvap/ubuntu-devstack.git
RUN cp ubuntu-devstack/localrc devstack/localrc
RUN wc -l devstack/localrc
RUN devstack/tools/create-stack-user.sh
RUN chown -Rf stack:stack devstack
RUN sudo -u stack bash -c devstack/stack.sh
