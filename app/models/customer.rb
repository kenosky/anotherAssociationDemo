class Customer < ActiveRecord::Base
    has_one :account
end
