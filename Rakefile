desc 'Installs all dependencies for running locally'
task :install do
  `bundle install --binstubs --path vendor/gems --without production`
end

desc 'Uninstalls all rubygems and temp files'
task :uninstall do
  rm_rf ['Gemfile.lock', 'vendor/', 'bin/', '.bundle/']
end

desc 'Bumps the current project version up'
task :bump do
  `agvtool bump -all`
end

desc 'Builds a .ipa file'
task :build => [:bump] do
  `bundle exec ipa build`
end

desc 'Distributes a new archive to TestFlight'
task :distribute => [:build] do
  `bundle exec ipa distribute`
end
