require 'spec_helper'

describe 'db2' do

  context 'on CentOS 7' do
    describe 'without any parameters' do
      let(:facts) {{
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemmajrelease => '7',
        :is_vagrant => 'true',
      }}
      let(:params) {{ }}

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('db2::service').that_subscribes_to('Class[db2::install]') }
      it { is_expected.to contain_file('/vagrant/vagrant/exp/db2exp.rsp') }
      it { is_expected.to contain_user('db2inst1') }
      it { is_expected.to contain_user('db2sdfe1') }
      it { is_expected.to contain_group('db2fsdm1') }
      it { is_expected.to contain_group('db2iadm1') }

    end
  end

end

