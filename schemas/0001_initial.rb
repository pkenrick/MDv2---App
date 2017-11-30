
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
  #   boolean :tester
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
    integer32 :api_id, optional: true
    string :title, optional: false
    boolean :complete, optional: false
    string :details
    datetime :due_date
    string :type
  end

end
