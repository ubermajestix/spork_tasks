require 'spork'
require 'spork/runner'
require 'rake'
require 'socket'
require 'timeout'

# Let's fork spork and put in the background and forget about it.
# You can start|stop|restart spork using this rake task
#
# Examples
#
#   rake spork:start
#   # => starts spork and detaches the process
#
#   rake spork:stop
#   # => kills the spork process based on the pid stored in tmp/spork.pid
#
#   rake spork:restart
#   # => stops then starts spork
#

module Spork
  class TaskHelper

    include Rake::DSL if defined? Rake::DSL

    def install
      namespace :spork do
        desc "Start spork server"
        task :start, :port do |_, args|
          port = args[:port]
          start_spork(port)
        end

        desc "Stop spork server"
        task :stop do
          stop_spork
        end

        desc "Restart spork server"
        task :restart => [:stop, :start]
      end
    end

    def start_spork(port = nil)
      options = []
      options << "-p#{port}" if port
      runner = Spork::Runner.new(options, $stderr, $stderr)
      port = port || runner.find_test_framework.default_port

      if port_bound?(port) || process_running?
        puts "\033[33m[Spork already running on port #{port}]\033[0m"
        return
      end

      begin
        pid = fork do
          $stdout = File.new('/dev/null', 'w')
          begin
            runner.run
          rescue => e
            $stderr.puts
            $stderr.puts "#{e.class} => #{e.message}"
            $stderr.puts e.backtrace.join("\n")
          end
        end

        # Detach the pid, keep track of the pid, and wait for Rails to start.
        Process.detach(pid)
        File.open(pid_file, "w"){|f| f.write pid}

        print "Starting spork..."
        timeout = 20
        seconds = 0
        until port_bound?(port)
          print '.'; $stdout.flush
          seconds += 1
          break if seconds > timeout
          sleep 1
        end

        # See if the process actually started
        if process_running?
          puts  "\033[32m[Spork running in background with pid #{pid}]\033[0m\n"
        else
          puts  "\033[31m[Spork failed to start]\033[0m\n"
        end
      rescue StandardError => e
        puts e.inspect
        puts  "\033[31m[Spork failed to start]\033[0m\n"
        stop_spork
      end
    end

    def stop_spork
      print "Stopping spork..."
      if pid_to_kill = pid
        begin
          Process.kill("INT", pid_to_kill)
          print "\033[32m[OK]\033[0m\n"
          sleep 1
        rescue Errno::ESRCH => e
          print "\033[33m[not running]\033[0m\n"
        rescue StandardError => e
          print "\033[31m[FAILED]\033[0m\n"
          puts e.inspect
        end
      else
        print "\033[33m[not running]\033[0m\n"
      end
    end

    def pid_file
      dir = File.join(Rails.root, 'tmp')
      File.join(dir, 'spork.pid')
    end

    def pid
      return unless File.exist?(pid_file)
      File.read(pid_file).to_i
    end

    def process_running?
      return false unless pid
      begin
        Process.kill(0, pid)
        return true
      rescue Errno::ESRCH => e
        return false
      end
    end

    def port_bound?(port)
      begin
        Timeout::timeout(1) do
          begin
            s = TCPSocket.new('localhost', port)
            s.close
            return true
          rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
            return false
          end
        end
      rescue Timeout::Error
        return false
      end
    end
  end
end
