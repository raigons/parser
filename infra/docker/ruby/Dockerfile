# Use an official Python runtime as a base image
FROM alpine:latest

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

ENV RUBY_MAJOR 2.5
ENV RUBY_VERSION 2.5.3
ENV RUBY_DOWNLOAD_SHA256 4fc8a9992de3e90191de369270ea4b6c1b171b7941743614cc50822ddc1fe654
ENV RUBYGEMS_VERSION 2.7.7
ENV BUNDLER_VERSION 1.17.1

# Install linux dependencies
RUN set -ex \
	\
  && apk add --update --virtual .ruby-builddeps \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    dpkg-dev dpkg \
    gcc \
    gdbm-dev \
    glib-dev \
    libc-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    openssl \
    openssl-dev \
    procps \
    readline-dev \
    ruby \
    tar \
    yaml-dev \
    zlib-dev \
    xz \

    && rm -rf /var/cache/apk/* \
    # && wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" \
    && wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" \
  	&& mkdir -p /usr/src/ruby \
  	&& tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1 \
  	&& rm ruby.tar.xz \
  	\
  	&& cd /usr/src/ruby \
  	\
  # hack in "ENABLE_PATH_CHECK" disabling to suppress:
  #   warning: Insecure world writable dir
  	&& { \
  		echo '#define ENABLE_PATH_CHECK 0'; \
  		echo; \
  		cat file.c; \
  	} > file.c.new \
  	&& mv file.c.new file.c \
  	\
  	&& autoconf \
  	&& ./configure --build="$gnuArch" --disable-install-doc --enable-shared	&& make -j "$(nproc)" \
  	&& make install \
  	\
  	&& runDeps="$( \
  		scanelf --needed --nobanner --recursive /usr/local \
  			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
  			| sort -u \
  			| xargs -r apk info --installed \
  			| sort -u \
  	)" \
  	&& apk add --virtual .ruby-rundeps $runDeps \
  		bzip2 \
  		ca-certificates \
  		libffi-dev \
  		openssl-dev \
  		yaml-dev \
  		procps \
  		zlib-dev \
  	&& cd / \
  	&& rm -r /usr/src/ruby \
  	\
  	&& gem update --system "$RUBYGEMS_VERSION" \
    && gem install --force bundler --version "$BUNDLER_VERSION" \
		&& gem update --system \
    && apk del .ruby-builddeps

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_BIN="$GEM_HOME/bin" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
	&& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"
