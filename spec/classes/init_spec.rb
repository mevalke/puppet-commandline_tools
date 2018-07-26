require 'spec_helper'
describe 'commandline_tools' do
  context 'with default values for all parameters' do
    it { should contain_class('commandline_tools') }
  end
end
