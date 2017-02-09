FROM ruby:2.2.4
COPY ./entrypoint.sh /

# below come instructions for Hydra OMS deployment
WORKDIR /opt
RUN apt-get update \
 && apt-get install -y git \
		       libpq-dev \
		       nodejs \
		       libqtwebkit-dev
RUN git clone https://github.com/latera/homs.git
WORKDIR /opt/homs
RUN gem install bundler
RUN bundle --without oracle
RUN find config -name '*.sample' | xargs -I{} sh -c 'cp $1 ${1%.*}' -- {}
RUN mkdir /tmp/config
RUN cp -r /opt/homs/config/* /tmp/config
EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
