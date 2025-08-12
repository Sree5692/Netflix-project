# ---- build ----
FROM node:18-alpine AS build
WORKDIR /app

# Copy only npm manifests (no yarn.lock)
COPY package*.json ./
RUN npm ci

# App source
COPY . .

# Build-time secret -> Vite env name
ARG TMDB_V3_API_KEY
ENV VITE_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}

RUN npm run build

# ---- runtime ----
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
