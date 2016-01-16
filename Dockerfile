FROM trenpixster/elixir

MAINTAINER Konrad Oleksiuk <konole@gmail.com>

# install node
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup | sudo bash - && \
    apt-get -y install python build-essential nodejs

ENV MIX_ENV dev
ENV PORT 4000

RUN mkdir /app
RUN mkdir /app/slackex

RUN sudo apt-get install -y git

RUN mix do local.rebar, local.hex --force

RUN mkdir -p /app/slackex

WORKDIR /app/slackex

COPY . /app/slackex

RUN npm install

RUN mix deps.get
RUN mix compile

EXPOSE 4000

CMD ["mix", "phoenix.server"]
