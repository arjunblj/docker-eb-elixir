FROM trenpixster/elixir:1.3.0

MAINTAINER Arjun Balaji <arjunblj@gmail.com>

RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app

ADD mix.* ./
RUN MIX_ENV=prod mix local.rebar
RUN MIX_ENV=prod mix local.hex --force
RUN MIX_ENV=prod mix deps.get

ADD package.json ./
RUN npm install

ADD . .
RUN MIX_ENV=prod mix compile

RUN NODE_ENV=production node_modules/brunch/bin/brunch build --production
RUN MIX_ENV=prod mix phoenix.digest

EXPOSE 4000

CMD MIX_ENV=prod mix ecto.migrate && \
  MIX_ENV=prod mix phoenix.server
