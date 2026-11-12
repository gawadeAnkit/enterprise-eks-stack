# ===================================================================
# DevOps Dashboard — Production Container
# ===================================================================
FROM node:20-alpine

WORKDIR /usr/src/app

ENV NODE_ENV=production \
    PORT=3000

COPY dashboard/package.json ./
COPY dashboard/src ./src

USER node

EXPOSE 3000

HEALTHCHECK --interval=20s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "fetch('http://localhost:3000/health').then(r=>r.ok?process.exit(0):process.exit(1)).catch(()=>process.exit(1))"

CMD ["node", "src/server.js"]

