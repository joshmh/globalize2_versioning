# These have translated fields but no versioned fields
class Post < ActiveRecord::Base
  translates :subject, :content
  validates_presence_of :subject  
end

class Blog < ActiveRecord::Base
  has_many :posts, :order => 'id ASC'
end


class Parent < ActiveRecord::Base
  translates :content
end

class Child < Parent
end

# These have translated and versioned fields
class Section < ActiveRecord::Base
  validates_presence_of :content
  translates :title, :content, :versioned => [ :content ], :limit => 5
end

class Content < ActiveRecord::Base
  translates :title, :article, :versioned => [ :article ], :limit => 5
end

class Wiki < Content
end