# Include hook code here
ActiveRecord::Base.send :include, Globalize::Model::ActiveRecord::Versioned
