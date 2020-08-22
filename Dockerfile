# This file isn't interesting for the CTF. I'm just using Docker to make it
# easier to deploy everything.

FROM nimlang/nim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

# -d:ssl is needed for httpclient to support HTTPS URLs
RUN nimble build -d:ssl -y

ENTRYPOINT ["./hashcache"]

EXPOSE 8080
