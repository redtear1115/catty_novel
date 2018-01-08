# frozen_string_literal: true

require 'secret-keeper'

namespace :config do
  desc 'pull Cloudconig from bitbucket and encrypt files'
  task :encrypt_files do
    SecretKeeper.encrypt_files
  end

  desc 'decrypt *.enc files to its location'
  task :decrypt_files do
    SecretKeeper.decrypt_files
  end
end
