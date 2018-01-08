# frozen_string_literal: true

namespace :bundler do
  after :install, :decrypt_files do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "config:decrypt_files OPENSSL_PASS=#{fetch(:openssl_pass)}"
        end
      end
    end
  end
end
