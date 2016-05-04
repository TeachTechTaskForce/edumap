require 'rails_helper'

describe Curriculum do
  context 'Associations' do
    it { should have_many(:lessons) }
  end
end
