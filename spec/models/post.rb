describe 'Post' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Post entity' do
    Post.entity_description.name.should == 'Post'
  end
end
