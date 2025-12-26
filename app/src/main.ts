import { Hono } from 'hono'
import { FluentClient } from '@fluent-org/logger'

const app = new Hono()
const logger = new FluentClient("myapp", {
  socket: {
    host: Deno.env.get("FLUENTD_HOST") || "localhost",
    port: parseInt(Deno.env.get("FLUENTD_PORT") || "8080"),
    timeout: 3000,
  }
})

app.get('/', async (c) => {
  await logger.emit('access', { path: c.req.url })
  return c.text('Hello Hono!')
})

Deno.serve(app.fetch)
