FROM node:18-alpine AS base

# nextjs dockerfile
#
WORKDIR /app

# Install dependencies
COPY package.json ./
RUN yarn install --frozen-lockfile

# Copy the rest of the application
COPY . .

# Build the application
RUN yarn build

# Run the application
CMD ["yarn", "run", "start"]