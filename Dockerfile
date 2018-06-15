FROM fedora:latest


RUN dnf install -y @xfce-desktop-environment tigervnc-server vim passwd sudo && dnf clean all
RUN dnf install wget -y; wget -O /usr/sbin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"
RUN chmod +x /usr/sbin/gosu
ARG VNC_PASS=password1
ARG BOXED_USER=boxer
RUN groupadd -g 1000 ${BOXED_USER} && useradd -u 1000 -g 1000 ${BOXED_USER}
RUN usermod -aG wheel ${BOXED_USER}
RUN echo "${VNC_PASS}" |passwd ${BOXED_USER} --stdin
RUN echo -e "#!/bin/bash\ndbus-uuidgen > /var/lib/dbus/machine-id\n/usr/sbin/gosu ${BOXED_USER} \"\$@\"" > /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    dnf install midori -y && \
    dnf clean all
ENTRYPOINT [ "/entrypoint.sh" ]
RUN mkdir /home/${BOXED_USER}/.vnc
RUN echo -e "${VNC_PASS}" | vncpasswd -f >> /home/${BOXED_USER}/.vnc/passwd
RUN chmod 600 /home/${BOXED_USER}/.vnc/passwd;chown -R ${BOXED_USER}:${BOXED_USER} /home/${BOXED_USER}
VOLUME [ "/home/${BOXED_USER}" ]
CMD ["vncserver", "-fg", "-xstartup", "xfce4-session"]