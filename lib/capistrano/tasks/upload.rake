namespace :deploy do
  desc 'Upload shared/config files'
  task :upload_shared_config_files do
    on roles(:all) do
      puts "#{shared_path}/config/database.yml"
      upload! 'config/database.yml', "/home/ec2-user/odinbook/shared/config/database.yml"
      upload! 'config/master.key', "/home/ec2-user/odinbook/shared/config/master.key"
    end
  end
end
