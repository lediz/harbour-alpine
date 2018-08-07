FROM alpine:3.8 as builder

RUN apk add --no-cache \
    bash \
    nano \
    git \
    gcc \
    make \
    binutils \
    fakeroot \
    upx \
    uncrustify \
    libc-dev \
    zlib-dev \
    ncurses-dev \
    mariadb-dev \
    postgresql-dev \
    sqlite-dev \
    unixodbc-dev && \
    git clone https://github.com/harbour/core.git

COPY arc4.c /core/src/rtl/
COPY mysql.c /core/contrib/hbmysql/

ENV HB_WITH_OPENSSL=no
ENV HB_BUILD_DYN=yes
ENV HB_BUILD_CONTRIB_DYN=yes

RUN cd core && \
    make install

FROM alpine:3.8
COPY --from=builder /usr/local/ /usr/local/
RUN apk add --no-cache \
    bash \

    # not needed, but like it
    nano \

    # needed for compile
    gcc \
    libc-dev \
    make \

    ## needed for -static/-fullstatic
    zlib-dev

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/harbour/

CMD ['sh']
