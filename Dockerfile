FROM hugomods/hugo:exts AS builder
WORKDIR /src
COPY . .
WORKDIR /src/exampleSite
RUN hugo mod get
RUN hugo --minify --environment production

FROM caddy:alpine
COPY --from=builder /src/exampleSite/public /usr/share/caddy
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 80 443
