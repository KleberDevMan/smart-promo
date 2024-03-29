# frozen_string_literal: true

# rubocop:disable Style/GlobalVars
module Rails7StartKit
  class << self
    def prompt!(message = 'Are you sure to continue? [y/Y]')
      puts message
      prompt = $stdin.gets.chomp

      return if prompt.downcase == 'y'

      puts 'Bye! See you next time!'
      exit 1
    end

    def rails7_header
      puts '~' * 80
      puts 'Rails 7. StartKit'
      puts '~' * 80
    end

    def rails7_startkit_greetings!
      rails7_header
      puts 'We are going to setup and run Rails 7 application'
      puts 'Relax and wait for some minutes'
      puts '~' * 80
    end

    def rails7_ready
      rails7_header
      puts 'What was done:'
      puts $steps_messages.join("\n")
      puts '~' * 80
      puts 'Welcome to RAILS 7!'
      puts '~' * 80
    end

    def system!(*args)
      system(*args) || abort("\n== Command #{args} failed ==")
    end

    def container_exec(container_name = 'rails', cmd = 'ls')
      docker_compose("exec #{ENV['TTY_OFF']} -e='RAILS_ENV=#{rails_env_name}' #{container_name} #{cmd}")
    end

    # rubocop:disable Style/OptionalBooleanParameter
    # rubocop:disable Layout/LineLength
    # rubocop:disable Metrics/ParameterLists
    def container_bash_exec(container_name = 'rails', cmd = 'ls', detached = false, as_root = false)
      detached = detached ? '-d' : ''
      as_root = as_root ? '--user root' : ''
      docker_compose("exec #{ENV['TTY_OFF']} #{as_root} -e=\"RAILS_ENV=#{rails_env_name}\" #{detached} #{container_name} /bin/bash -c \"#{cmd}\"")
    end
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Layout/LineLength
    # rubocop:enable Style/OptionalBooleanParameter

    def containers_information
      puts
      puts '~' * 80
      system("docker ps --format \"table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.ID}}\"")
      puts '~' * 80
      puts
    end

    # TODO: update with --remove-orphans

    def start_all_containers
      docker_compose('up -d')
    end

    def stop_all_containers
      docker_compose('down')
    end
  end
end
# rubocop:enable Style/GlobalVars
