packages = ['apache2']
apache2_root = "/etc/apache2/"
modules = ['rewrite', 'headers', 'vhost_alias']

for package in packages
    package "#{package}"
end

cookbook_file "#{apache2_root}sites-enabled/coders" do
    source "coders"
end

cookbook_file "#{apache2_root}sites-enabled/000-default" do
    action :delete
end


for mod in modules
    link "#{apache2_root}mods-enabled/#{mod}.load" do
      to "#{apache2_root}mods-available/#{mod}.load"
    end
end
