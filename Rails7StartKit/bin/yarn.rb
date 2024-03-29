# frozen_string_literal: true

module Rails7StartKit
  class << self
    def init_nvm
      init_nvm_command = 'source /opt/.nvm/nvm.sh'
      init_nvm_command = '/bin/bash /opt/.nvm/nvm.sh' if inside_rails_conainer?
      init_nvm_command
    end

    def yarn_install
      command = "#{init_nvm} && yarn install"
      run_rails_command(command)
    end

    def yarn_build
      command = "#{init_nvm} && yarn build"
      run_rails_command(command)
    end
  end
end
