require 'spec_helper'

# memoapp サーバーテスト

# port テスト
describe port(22) do
  it { should be_listening }
end

describe port(80) do
  it { should be_listening }
end

# OSとgit
describe package('git'), :if => os[:family] == 'amazon' do
  it { should be_installed }
end

# nginx テスト
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

# unicorn テスト
describe file('/home/ec2-user/.rbenv/shims/unicorn') do
  it { should be_executable }
end

# ruby バージョン
describe command('ruby -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /ruby 2\.5\.8/ }
end

# rubyに必要なパッケージ
%w{git-core gcc gcc-c++ gdbm-devel libffi-devel libselinux-python libyaml-devel ncurses-devel openssl-devel sqlite-devel readline-devel zlib-devel}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# rails バージョン
describe command('rails -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /Rails 5\.2\.4\.4/ }
end

# アプリテスト
describe file('/home/ec2-user/memoapp') do
  it { should be_directory }
  it { should be_executable }
end