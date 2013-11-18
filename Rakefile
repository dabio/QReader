desc 'Installs all dependencies for running locally'
task :install do
  `bundle install --binstubs --path vendor/gems --without production`
end

desc 'Uninstalls all rubygems and temp files'
task :uninstall do
  rm_rf ['Gemfile.lock', 'vendor/', 'bin/', '.bundle/']
end

