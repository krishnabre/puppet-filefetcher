require 'spec_helper'
describe 'filefetcher' do

  context 'with defaults for all parameters' do
    it { should contain_class('filefetcher') }
  end
end
