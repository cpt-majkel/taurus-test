FROM centos:7

RUN yum -y install epel-release

#install tango
ADD /maxiv.repo /etc/yum.repos.d/
RUN yum install -y omniORB-4.1.7
RUN yum install -y libtango9

# install sardana dependencies
RUN yum install -y python ipython python-h5py python-lxml python-numpy\
                       python-ply python-pytango python-qt4\
                       python-qwt5-qt4 python-guiqwt pymca

# install pip
RUN yum install -y python-pip

#install taurus
RUN pip install -y python-taurus

# install spyder V3 from pypi
RUN pip install spyder==3

# instal virtual monitor
RUN yum install -y xvfb

#rpm builder
ADD /tango-common-9.2.5-9.el7.centos.maxlab.x86_64.rpm /tango-common-9.2.5-9.el7.centos.maxlab.x86_64.rpm
RUN rpm -i tango-common-9.2.5-9.el7.centos.maxlab.x86_64.rpm

# configure supervisord
ADD /supervisord.conf /etc/supervisor/conf.d/

# start supervisor as deamon
CMD ["/usr/bin/supervisord"]
