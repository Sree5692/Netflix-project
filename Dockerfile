FROM node:18-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci && npm install @mui/base --save

COPY . .

ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://www.themoviedb.org/"

# Build even if there are TS errors (temporary)
RUN npm run build -- --noEmitOnError false

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
