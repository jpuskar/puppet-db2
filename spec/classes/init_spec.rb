require 'spec_helper'

describe 'db2' do
  context 'on CentOS 6' do
    describe 'without any parameters' do
      let(:facts) {{
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemmajrelease => '6',
      }}
      let(:params) {{ }}

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('db2::params') }
      it { is_expected.to contain_class('db2::install').that_comes_before('db2::config') }
      it { is_expected.to contain_class('db2::config') }
      it { is_expected.to contain_class('db2::service').that_subscribes_to('db2::config') }

      it { is_expected.to contain_service('db2') }
      it { is_expected.to contain_package('db2').with_ensure('present') }
    end
  end

  context 'on CentOS 7' do
    describe 'without any parameters' do
      let(:facts) {{
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemmajrelease => '7',
      }}
      let(:params) {{ }}

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('db2::params') }
      it { is_expected.to contain_class('db2::install').that_comes_before('db2::config') }
      it { is_expected.to contain_class('db2::config') }
      it { is_expected.to contain_class('db2::service').that_subscribes_to('db2::config') }

      it { is_expected.to contain_service('db2') }
      it { is_expected.to contain_package('db2').with_ensure('present') }
    end
  end

  context 'unsupported operating system' do
    describe 'db2 class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('db2') }.to raise_error(Puppet::PreformattedError) }
    end
  end

  # Once rspec-puppet-facts works can use this
  #context 'supported operating systems' do
  #  on_supported_os.each do |os, facts|
  #    context "on #{os}" do
  #      let(:facts) do
  #        facts
  #      end

  #      context "db2 class without any parameters" do
  #        let(:params) {{ }}

  #        it { is_expected.to compile.with_all_deps }

  #        it { is_expected.to contain_class('db2::params') }
  #        it { is_expected.to contain_class('db2::install').that_comes_before('db2::config') }
  #        it { is_expected.to contain_class('db2::config') }
  #        it { is_expected.to contain_class('db2::service').that_subscribes_to('db2::config') }

  #        it { is_expected.to contain_service('db2') }
  #        it { is_expected.to contain_package('db2').with_ensure('present') }
  #      end
  #    end
  #  end
  #end

  #context 'unsupported operating system' do
  #  describe 'db2 class without any parameters on Solaris/Nexenta' do
  #    let(:facts) {{
  #      :osfamily        => 'Solaris',
  #      :operatingsystem => 'Nexenta',
  #    }}

  #    it { expect { is_expected.to contain_package('db2') }.to raise_error(RSpec::Expectations::ExpectationNotMetError) }
  #  end
  #end
end

