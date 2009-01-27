# This is the fully realized schema including translation/versioning tables
ActiveRecord::Schema.define do
  create_table :blogs, :force => true do |t|
    t.string      :description
  end

  create_table :posts, :force => true do |t|
    t.references  :blog
  end

  create_table :post_translations, :force => true do |t|
    t.string      :locale
    t.references  :post
    t.string      :subject
    t.text        :content
  end

  create_table :sections, :force => true do |t|
    t.integer     :version
  end

  create_table :section_translations, :force => true do |t|
    t.integer     :version
    t.string      :locale
    t.references  :section
    t.string      :title
    t.text        :content
  end
end
  
