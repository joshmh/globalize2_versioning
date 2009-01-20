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
  end

  create_table :section_translations, :force => true do |t|
    t.integer     :version
    t.string      :locale
    t.references  :post
    t.string      :title
    t.text        :content
    t.text        :untranslated_content
  end

  create_table :forums, :force => true do |t|
    t.string      :title
  end

  create_table :forum_translations, :force => true do |t|
    t.integer     :version
    t.references  :post
    t.text        :content
  end
end
  
