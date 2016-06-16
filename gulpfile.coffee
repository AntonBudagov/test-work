gulp = require('gulp')
jade = require('gulp-jade')
haml = require('gulp-ruby-haml')
sass = require('gulp-sass')
concatCss = require('gulp-concat-css')
autoprefixer = require('gulp-autoprefixer')
coffee = require('gulp-coffee')
rjs = require ('gulp-requirejs')
uglify = require('gulp-uglify')
clean = require('gulp-clean')
wiredep = require('wiredep').stream
useref = require('gulp-useref')
gulpif = require('gulp-if')
notify = require('gulp-notify')
browserSync = require('browser-sync').create()

# SERVER #############################################
gulp.task 'serve', ->
    browserSync.init
      server: "dist/"
    browserSync.watch('dist/').on('change', browserSync.reload)

# JADE #############################################
gulp.task 'jade', ->
  gulp.src 'app/jade/*.jade'
    .pipe jade(pretty: true)
    .pipe gulp.dest 'dist'
# HAML #############################################
gulp.task 'haml', ->
  gulp.src 'app/haml/**/*.haml'
    .pipe(haml().on 'error', notify.onError())
    .pipe gulp.dest('dist')

  # gulp.src 'dist/includes/', read: no
  #   .pipe do clean

# SASS #############################################
gulp.task 'sass',  ->
  gulp.src('app/sass/*.sass')
    .pipe sass(outputStyle: 'compressed').on 'error', notify.onError()
    # .pipe sass
    # .pipe concatCss("sass/bundle.css")
    .pipe autoprefixer('last 2 version', '> 1%', 'IE 9' )
    .pipe gulp.dest 'dist/css'

  # gulp.src 'dist/css', read: no
  #   .pipe do clean

# BUILD #############################################
gulp.task 'build', ['coffee'], ->
  rjs
    baseUrl: 'js'
    name: '../app/bower_components/almond/almond'
    include: ['main']
    insertRequire: ['main']
    out: 'all.js'
    wrap: on
  .pipe do uglify
  .pipe gulp.dest 'dist/js'

  gulp.src 'js/', read: no
    .pipe do clean

# COFFEE ############################################
gulp.task 'coffee', ->
  gulp.src('app/coffee/*.coffee')
  # .pipe coffee(bare: true).on 'error', notify.onError()
    .pipe do coffee
    .pipe gulp.dest 'js'

# WATCH #############################################
gulp.task 'watch', ->
  # gulp.watch 'app/jade/*.jade', ['jade']
  gulp.watch 'app/haml/**/*.haml', ['haml']
  gulp.watch 'app/sass/*.sass', ['sass']
  gulp.watch 'app/coffee/*.coffee', ['coffee', 'build']

# DEFAULT #############################################
gulp.task 'default', ['haml', 'watch', 'build', 'serve']
