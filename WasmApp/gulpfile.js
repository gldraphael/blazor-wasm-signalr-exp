const { src, dest, watch: gulpWatch } = require('gulp')
const cssFile = "assets/css/app.css"
const tailwindConfig = "tailwind.config.js"

function css () {
  const postcss = require('gulp-postcss')

  return src(cssFile)
    .pipe(postcss())
    .pipe(dest('wwwroot/dist/css'))
}
exports.css = css

function watch() {
  return gulpWatch([cssFile, tailwindConfig], css)
}
exports.watch = watch
exports.default = watch
