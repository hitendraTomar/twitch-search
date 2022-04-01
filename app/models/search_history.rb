# frozen_string_literal: true

class SearchHistory < ApplicationRecord
  belongs_to :user
end
