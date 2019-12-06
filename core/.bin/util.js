
exports.read = () => new Promise((resolve, reject) => {
  process.stdin.resume()
  process.stdin.setEncoding('utf8')

  let input = ''
  process.stdin.on('data', chunk => input += chunk)

  process.stdin.on('end', () => {
    resolve(input)
  })

  process.stdin.on('error', (err) => {
    reject(err)
  })
})

exports.run = fn => fn().then(output => output && console.log(output), e => console.error(e))
