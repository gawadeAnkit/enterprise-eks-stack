# ===================================================================
# Nginx Reverse Proxy  
# Lightweight config: security headers + healthcheck endpoint
# ===================================================================
FROM nginx:1.27-alpine

LABEL maintainer="gawadeAnkit"
LABEL description="Hardened Nginx reverse proxy for enterprise webapp"

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom config
COPY docker/proxy/nginx.conf /etc/nginx/conf.d/app.conf

# Non-root: nginx master stays root (required) but workers don't
# Nginx alpine already runs workers as nginx (101)

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

CMD ["nginx", "-g", "daemon off;"]

