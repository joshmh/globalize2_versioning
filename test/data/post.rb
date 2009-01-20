# These have translated fields but no versioned fields
class Post < ActiveRecord::Base
  belongs_to :post
  translates :subject, :content
  validates_presence_of :subject
end

class Blog < ActiveRecord::Base
  has_many :posts, :order => 'id ASC'
end

# These have translated and versioned fields
class Section < ActiveRecord::Base
  translates :title, :content
  versions   :content, :untranslated_content
end

# These have versioned but no translated fields
class Forum < ActiveRecord::Base
  versions :content
end
