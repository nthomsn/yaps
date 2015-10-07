apt-get update
apt-get install -y git zlib1g-dev ruby-full build-essential nodejs sqlite3 libsqlite3-dev
gem install rubygems-update
gem install sqlite3
gem install rails
cd /home/vagrant/yaps
bundle
gem pristine --all
