require 'rails_helper'

RSpec.describe Function, type: :model do
  subject { create :function }

  it { is_expected.to validate_presence_of :usage }
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_presence_of :user }

  def generate_name(code)
    subject.name = nil
    subject.code = code
    subject.validate
  end

  describe '#name' do
    it 'must exist' do
      generate_name 'def;end'
      expect(subject.errors.added?(:name, :blank)).to be_truthy
    end

    it 'must be unique' do
      duplicate = subject.dup
      duplicate.validate
      expect(duplicate.errors.added?(:name, :taken, value: subject.name)).to be_truthy
    end

    it 'allow camel case' do
      generate_name 'def cameCase; end'
      expect(subject).to be_valid
    end

    it 'allow to have number in it' do
      generate_name 'def foo1; end'
      expect(subject).to be_valid
    end

    it 'don\'t allow اسم عربي' do
      generate_name 'def عربي; x = 1; end'
      expect(subject.errors.added?(:name, :invalid, value: 'عربي')).to be_truthy
    end
  end

  describe '#code' do
    it 'do not allow more than one function' do
      generate_name  "def foo1; end\ndef foo2; end"
      expect(subject.errors.added?(:code, :many_functions)).to be_truthy
    end

    it 'do not allow code that does not define a function' do
      generate_name  "puts 'hello world'"
      expect(subject.errors.added?(:code, :no_functions)).to be_truthy
    end
  end
end
