namespace :deploy do
  desc "Print current_path"
  task :print_current_path do
    on roles(:all) do
      puts "Uploading to #{current_path}"
    end
  end
end
