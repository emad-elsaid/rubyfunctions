require 'rails_helper'


RSpec.describe Function, type: :model do
  subject { create :function }

  def generate_name (code)
    subject.code = code
    subject.validate
  end

  describe '#name' do
    it 'must exist' do
      generate_name 'def;end'
      expect(subject.errors[:name]).to be_present
    end


    it 'must be unique' do
      duplicate = subject.dup
      duplicate.validate
      expect(duplicate.errors[:name]).to be_present
    end
  end

  it 'allow camel case' do
    generate_name 'def cameCase; end'
    expect(subject).to be_valid
  end

  it 'allow to have number in it' do 
    generate_name 'def foo1; end'
    expect(subject).to be_valid
  end

  it 'don\'t allow space' do
    generate_name('def fo o a; x = 1; end')
    expect(subject).to_not be_valid
  end

  it 'don\'t allow backlash' do
    generate_name 'def fo\o; x = 1; end'
    expect(subject).to_not be_valid
  end

  it 'don\'t allow اسم عربي' do
    generate_name 'def عربي; x = 1; end'
    expect(subject).to_not be_valid
  end

  it { is_expected.to validate_presence_of :usage }
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_presence_of :user }
end
