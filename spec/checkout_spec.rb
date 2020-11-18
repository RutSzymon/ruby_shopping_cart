# frozen_string_literal: true

require_relative '../checkout'

describe Checkout do
  subject { Checkout.new({ item_rules: [:two_or_more_red_scarfs], total_rules: [:over_sixty] }) }

  it 'should handle case 1' do
    subject.scan('001')
    subject.scan('002')
    subject.scan('003')

    expect(subject.total).to eq('£66.78')
  end

  it 'should handle case 2' do
    subject.scan('001')
    subject.scan('003')
    subject.scan('001')

    expect(subject.total).to eq('£36.95')
  end

  it 'should handle case 3' do
    subject.scan('001')
    subject.scan('002')
    subject.scan('001')
    subject.scan('003')

    expect(subject.total).to eq('£73.76')
  end

  it 'should handle new promotional rules' do
    subject = Checkout.new({
                             item_rules: %i[two_or_more_red_scarfs three_or_more_silk_dresses],
                             total_rules: %i[over_sixty over_five_items]
                           })
    subject.scan('001')
    subject.scan('002')
    subject.scan('001')
    subject.scan('001')
    subject.scan('003')
    subject.scan('003')
    subject.scan('003')

    expect(subject.total).to eq('£80.45')
  end
end
