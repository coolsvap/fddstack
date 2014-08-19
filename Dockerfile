FROM            fedora
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
RUN chmod -Rf 755 /opt/stack
RUN chown -Rf stack:stack /opt/stack
RUN grep -rl 'Defaults    requiretty' /etc/sudoers | xargs sed -i 's/Defaults    requiretty/#Default requiretty/g'
RUN mkdir /tmp/original /tmp/overlay
RUN mount --bind /proc/sys/net/ipv4/ /tmp/original
RUN unionfs-fuse -o nonempty /tmp/overlay=RW:/tmp/original=RO /proc/sys/net/ipv4/
RUN echo "" > /proc/sys/net/ipv4/ip_local_reserved_ports
RUN umount /proc/sys/net/ipv4/
RUN su stack bash -c devstack/stack.sh
