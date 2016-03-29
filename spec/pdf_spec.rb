require 'pdf/reader'

describe 'Fancytabs PDF' do
  reader = PDF::Reader.new('fancytabs.pdf')
  it 'should have 4 pages' do
    reader.page_count.should eq(4)
  end
  it 'should be made by TeX' do
    reader.info[:Creator].should eq('TeX')
  end
  it 'should have 6 fonts on page 2' do
    reader.pages[1].fonts.keys.size.should eq(6)
  end
  it 'should start with a title' do
    reader.pages[0].text.should match('The fancytabs package')
  end
end
