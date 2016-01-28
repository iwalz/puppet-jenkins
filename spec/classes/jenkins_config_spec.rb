require 'spec_helper'

describe 'jenkins', :type => :module do
  let(:facts) { { :osfamily => 'RedHat', :operatingsystem => 'RedHat' } }

  context 'config' do
    context 'default' do
      it { should contain_class('jenkins::config') }
    end

    context 'create config' do
      let(:params) { { :config_hash => { 'AJP_PORT' => { 'value' => '1234' } } }}
      it { should contain_jenkins__sysconfig('AJP_PORT').with_value('1234') }
    end

    context 'custom localstatedir' do
      context 'not in config_hash' do
        let (:params) {{ :config_hash => {}, :localstatedir => '/custom/jenkins', }}
        it { should contain_jenkins__sysconfig('JENKINS_HOME').with_value('/custom/jenkins') }
      end
      context 'also in the config hash' do
        let (:params) {{
          :config_hash => {
            'JENKINS_HOME' => { 'value' => '/foobar/jenkins' },
          },
          :localstatedir => '/custom/jenkins',
        }}
        it { should contain_jenkins__sysconfig('JENKINS_HOME').with_value('/foobar/jenkins') }
      end
    end
  end

end
