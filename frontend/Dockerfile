FROM node:18-alpine AS base

RUN mkdir -p /usr/src/app
WORKDIR /app

# Install dependencies
COPY package.json package.json
RUN yarn install

# Copy the rest of the application
COPY . /app

RUN yarn next build