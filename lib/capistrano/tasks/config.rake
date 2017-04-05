namespace :config do

  desc 'Remove config files'
  task :remove do
    on roles(:all) do
      fetch(:linked_files, []).each do |file|
        execute "rm -f #{shared_path.join(file)}"
      end
    end
  end

  desc 'Link config files'
  task :soft_link do
    on roles(:all) do
      fetch(:linked_files, []).each do |file|
        config_file = fetch(:config_dir) + file
        execute "ln -s #{config_file} #{shared_path.join(file)}"
      end
    end
  end

end
