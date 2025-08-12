# ---------- Build stage ----------
FROM node:18-alpine AS build
WORKDIR /app

# Copy npm manifests and install deps
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .

# Build-time args -> Vite env (must start with VITE_)
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"

RUN npm run build

# ---------- Runtime stage ----------
FROM nginx:alpine
# (optional) clean default site config if you add your own
# RUN rm /etc/nginx/conf.d/default.conf

# Copy built static files
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
