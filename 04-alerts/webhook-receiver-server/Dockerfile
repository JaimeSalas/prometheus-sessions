FROM node:18-alpine

WORKDIR /opt/app

COPY . . 

RUN npm ci 

CMD [ "node", "app"]