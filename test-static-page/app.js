import express from 'express'
import { glob } from 'glob'
import { createProxyMiddleware } from 'http-proxy-middleware'

const port = 5100

const app = express()

// const dirs = await glob('./src/*')
// dirs.forEach((dir) => {
// })

app.use(express.static('./src'))

// 反向代理
app.use("/js", createProxyMiddleware(`http://localhost:5000/js`));
app.use("/images", createProxyMiddleware(`http://localhost:5000/images`));
app.use("/api", createProxyMiddleware(`http://localhost:5000/api`));
app.use("/UpLoad", createProxyMiddleware(`http://localhost:5000/UpLoad`));
app.use("/Basket", createProxyMiddleware(`http://localhost:5000/Basket`));

// app.all('*', (req, res, next) => {
//     console.log('res', req);
//     next()
// })

app.listen(port, () => {
    console.log(`express server start at http://localhost:${port}`);
})