module.exports = function (grunt) {

  'use strict';

  // Project configuration.
  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    jshint: {
      files: [
        'Gruntfile.js',
        'public/scripts/**/*.js',
        '!public/scripts/lib/**/*.js',
        '!public/scripts/*.min.js'
      ],
      options: {
        browser: true,
        camelcase: true,
        curly: true,
        eqeqeq: true,
        forin: true,
        immed: true,
        indent: 2,
        latedef: true,
        newcap: true,
        noarg: true,
        noempty: true,
        quotmark: 'single',
        undef: true,
        unused: true,
        trailing: true,
        strict: true,
        predef: [
          'requirejs', 'require', 'define',
          'module',
          '_gaq', 'ga',
          'console',
          'angular'
        ]
      }
    },
    uglify: {

    },
    requirejs: {

    },
    slim: {
      production: {
        files: {
          'public/views/experiences.html': 'public/views/experiences.slim',
          'public/views/home.html': 'public/views/home.slim',
          'public/views/projects.html': 'public/views/projects.slim',
          'public/views/skills.html': 'public/views/skills.slim',
          'public/views/skills_javascript.html': 'public/views/skills_javascript.slim',
          'public/views/studies.html': 'public/views/studies.slim'
        }
      }
    },
    less: {
      production: {
        files: {
          'public/css/main.css': 'public/css/main.less'
        }
      }
    },
    csslint: {
      src: [

      ]
    },
    watch: {
      less: {
        files: ['**/*.less'],
        tasks: ['less']
      },
      slim: {
        files: ['public/views/*.slim'],
        tasks: ['slim']
      }
    }
  });

  // Load tasks.
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-requirejs');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-slim');

  // Task definition.
  grunt.registerTask('default', ['jshint', 'less', 'slim']);
  grunt.registerTask('heroku', ['less']);

};