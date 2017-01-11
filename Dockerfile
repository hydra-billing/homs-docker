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
RUN bundle --without oracle
RUN mv /opt/homs/config /opt
EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
