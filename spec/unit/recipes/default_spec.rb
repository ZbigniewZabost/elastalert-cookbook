#
# Cookbook Name:: elastalert
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'elastalert::default' do
  context 'When all attributes are default, on an ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'clones elastalert repo' do
      expect(chef_run).to checkout_git('elastalert').with(revision: 'v0.1.3')
    end
  end
end
