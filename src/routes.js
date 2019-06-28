const Router = require('koa-router')
const pkg = require('./package')
const router = new Router()

// Root
router.get('/', ctx => {
  ctx.body = {
    message: 'Hello from API for Kiwi.com Summer Camp Entry Task!',
    version: pkg.version,
  }
  ctx.status = 200
})

// Liveness check
router.get('/health', ctx => {
  ctx.status = 200
})

// Ready check
router.get('/readiness', ctx => {
  ctx.status = 200
})

const routes = router.routes()
module.exports = routes
