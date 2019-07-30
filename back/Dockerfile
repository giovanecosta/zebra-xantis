FROM elixir:1.7.4

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix archive.install hex phx_new 1.4.9 --force

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix do compile

CMD ["mix", "phx.server"]
