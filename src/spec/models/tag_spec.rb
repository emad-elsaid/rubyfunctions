require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { create :tag }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to have_and_belong_to_many :functions }

  it { is_expected.to allow_value('tag').for :name }
  it { is_expected.to allow_value('another-valid-tag').for :name }

  it { is_expected.to_not allow_value('also_a_tag').for :name }
  it { is_expected.to_not allow_value('a.tag').for :name }
  it { is_expected.to_not allow_value('sapces in tag').for :name }
  it { is_expected.to_not allow_value('تاج_عربي').for :name }
  it { is_expected.to_not allow_value('notvalid#tag').for :name }
  it { is_expected.to_not allow_value('not+validtag').for :name }
  it { is_expected.to_not allow_value('not!valid!tag').for :name }
  it { is_expected.to_not allow_value('notvalid\tag').for :name }
  it { is_expected.to_not allow_value('not/validtag').for :name }
end
