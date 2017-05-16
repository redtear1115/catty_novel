namespace :config do

  desc 'Link config files from cloudconfig to shared'
  task :link do
    on roles(:all) do
      fetch(:linked_files, []).each do |file|
        execute "rm -f #{shared_path.join(file)}"
        config_file = fetch(:config_dir) + file
        execute "ln -s #{config_file} #{shared_path.join(file)}"
      end
    end
  end

end