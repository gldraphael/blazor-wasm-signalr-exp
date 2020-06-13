const { src, dest, watch } = require('gulp')
const cssFile = "assets/css/app.css"
const tailwindConfig = "tailwind.config.js"

function css () {
  const postcss = require('gulp-postcss')

  return src(cssFile)
    .pipe(postcss())
    .pipe(dest('wwwroot/dist/css'))
}
exports.css = css;

exports.default = function() {
  return watch([cssFile, tailwindConfig], css)
}
