
schema "0001 initial" do

  # Examples:
  #
  # entity "Person" do
  #   string :name, optional: false
  #
  #   has_many :posts
  # end
  #
  # entity "Post" do
  #   string :title, optional: false
  #   string :body
  #
  #   datetime :created_at
  #   datetime :updated_at
  #
  #   has_many :replies, inverse: "Post.parent"
  #   belongs_to :parent, inverse: "Post.replies"
  #
  #   belongs_to :person
  # end

  entity 'Task' do
    string :title, optional: false
    # string :description, optional: true
    # datetime :due_date, optional: true
    # boolean :complete, optional: false
    # integer32 :user_id, optional: false
  end

end
