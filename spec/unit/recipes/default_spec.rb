require 'spec_helper'

describe 'elastalert::default' do
  context 'When all attributes are default, on an ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    describe 'when elastalert is being installed' do
      context 'for the 1st time' do
        before do
          allow(::File).to receive(:exist?).with(anything).and_call_original
          allow(::File).to receive(:exist?).with('/opt/elastalert/.env').and_return(false)
          allow(::File).to receive(:exist?).with('/opt/elastalert/.env/bin/elastalert-create-index').and_return(false)
          stub_command("curl -XGET 'http://localhost:9200/elastalert_status/' -s | grep '@timestamp'").and_return(false)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'installs elastalert' do
          expect(chef_run).to run_python_execute('/opt/elastalert/setup.py install')
        end

        it 'installs pip requriments' do
          resource = chef_run.python_execute('/opt/elastalert/setup.py install')
          expect(resource).to notify('pip_requirements[/opt/elastalert/requirements.txt]').to(:install).immediately
        end

        it 'creates elastalert ES index' do
          expect(chef_run).to run_python_execute('setup elastalert index')
        end
      end

      context 'for the next time' do
        before do
          allow(::File).to receive(:exist?).with(anything).and_call_original
          allow(::File).to receive(:exist?).with('/opt/elastalert/.env').and_return(true)
          allow(::File).to receive(:exist?).with('/opt/elastalert/.env/bin/elastalert-create-index').and_return(true)
          stub_command("curl -XGET 'http://localhost:9200/elastalert_status/' -s | grep '@timestamp'").and_return(true)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'does not reinstall elastalert' do
          resource = chef_run.python_execute('/opt/elastalert/setup.py install')
          expect(resource).to do_nothing
        end

        it 'does not reinstall pip requriments' do
          resource = chef_run.pip_requirements('/opt/elastalert/requirements.txt')
          expect(resource).to do_nothing
        end

        it 'does not tries to create ES index' do
          resource = chef_run.python_execute('setup elastalert index')
          expect(resource).to do_nothing
        end
      end
    end
  end
end
