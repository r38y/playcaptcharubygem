module.exports = function(grunt) {

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    exec: {
      'create-gem': {
        cmd: 'gem build playcaptcha.gemspec'
      },
      'mv-to-dist': {
        cmd: 'mv playcaptcha-<%= pkg.version %>.gem dist',
      },
      'rm-spec': {
        cmd: 'rm playcaptcha.gemspec',
      },
    }

  });

  grunt.loadNpmTasks('grunt-exec');

  grunt.registerTask('create-spec', 'Set the gem version from package.json', function() {
  
    var version = grunt.config.get('pkg').version;
    var gemSpecTemplate = grunt.file.read('playcaptcha.gemspec.template');
    var gemSpec = gemSpecTemplate.replace('<version>', version);
    grunt.file.write('playcaptcha.gemspec', gemSpec);
  
  });

  grunt.registerTask('package', ['create-spec', 'exec:create-gem', 'exec:mv-to-dist', 'exec:rm-spec']);

}