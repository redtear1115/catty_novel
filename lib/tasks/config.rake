# frozen_string_literal: true

require 'secret-keeper'

namespace :config do
  desc 'encrypt files based on encrypt_from & encrypt_to in secret-keeper.yml'
  task :encrypt_files do
    SecretKeeper.encrypt_files
  end

  desc 'decrypt files based on decrypt_from & decrypt_to in secret-keeper.yml'
  task :decrypt_files do
    SecretKeeper.decrypt_files
  end
end
