ARG ALPINE_VERSION=3.23

FROM node:24-alpine${ALPINE_VERSION} AS builder
WORKDIR /build-stage
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
# RUN nmp run build

FROM alpine:${ALPINE_VERSION}
WORKDIR /usr/src/app
RUN apk add --no-cache libstdc++ dumb-init \
  && addgroup -g 1000 node && adduser -u 1000 -G node -s /bin/sh -D node \
  && chown node:node ./
COPY --from=builder /usr/local/bin/node /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
USER node
# COPY --from=builder /build-stage/node_modules ./node_modules
# COPY --from=builder /build-stage/dist ./dist
COPY --from=builder /build-stage/. .
EXPOSE 3000
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["dumb-init", "node", "app.js"]
