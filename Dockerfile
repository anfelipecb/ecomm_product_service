# Build stage
FROM node:24-alpine AS builder

WORKDIR /app

# Copy package files first (better layer caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev

# Copy source (explicit src ensures it's in build context with Box Drive)
COPY src ./src
COPY . .

# Production stage
FROM node:24-alpine

WORKDIR /app

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

# Copy from builder (chown so nodejs user can read)
COPY --from=builder --chown=nodejs:nodejs /app .

USER nodejs

EXPOSE 3001

ENV NODE_ENV=production
ENV PORT=3001

CMD ["node", "src/index.js"]