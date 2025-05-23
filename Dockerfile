FROM gentoo/stage3 AS base

ADD ./scripts/write_package_flags.sh	/scripts/write_package_flags.sh
ADD ./scripts/start.sh								/scripts/start.sh
ADD ./scripts/install_openssl.sh			/scripts/install_openssl.sh
ADD ./scripts/install_vpcs.sh					/scripts/install_vpcs.sh
ADD ./scripts/install_python.sh				/scripts/install_python.sh

ADD ./config.ini				/config.ini
ADD ./requirements.txt	/requirements.txt

ENV LD_LIBRARY_PATH="/opt/openssl-0.9.8/lib"

# system package & dependencies from package manager (emerge)
RUN emerge-webrsync

RUN emerge --oneshot -vq dev-lang/go-bootstrap

RUN /scripts/write_package_flags.sh

RUN emerge -vq \
		app-emulation/qemu \
		app-emulation/libvirt \
		app-containers/docker \
		sys-fs/mtools \
		net-misc/ubridge \
		app-emulation/dynamips \
		net-misc/bridge-utils \
		sys-libs/glibc

FROM base AS deps

# VPCS
RUN /scripts/install_vpcs.sh

# IOU support
RUN /scripts/install_openssl.sh

# install python & install gns3server
RUN /scripts/install_python.sh

FROM deps AS production

WORKDIR /data
VOLUME ["/data"]

CMD [ "/scripts/start.sh" ]
