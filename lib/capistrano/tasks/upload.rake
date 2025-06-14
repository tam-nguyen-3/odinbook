namespace :deploy do
  desc 'Upload shared/config files'
  task :upload_shared_config_files do
    on roles(:all) do
      puts "Uploading to #{shared_path}/config/database.yml, #{shared_path}/config/master.key..."
      puts "test #{fetch(:puma_rackup)}"
      upload! 'config/database.yml', "#{shared_path}/config/database.yml"
      upload! 'config/master.key', "#{shared_path}/config/master.key"
    end
  end
end
