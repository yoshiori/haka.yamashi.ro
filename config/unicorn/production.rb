RAILS_ROOT = File.expand_path("../..", __dir__)

# Number of worker process
worker_processes 3

# listen "#{RAILS_ROOT}/tmp/unicorn.sock", :backlog => 64
# listen 8080, :tcp_nopush
listen "/tmp/unicorn.sock"

# 60 seconds (the default)
# timeout 30

pid "#{RAILS_ROOT}/tmp/pids/unicorn.pid"

# By default, the Unicorn Logger will write to stderr.
stderr_path "#{RAILS_ROOT}/log/unicorn.log"
stdout_path "#{RAILS_ROOT}/log/unicorn.log"

# use correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{RAILS_ROOT}/Gemfile"
end

# preload
preload_app true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
