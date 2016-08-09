class Game < ApplicationRecord
  serialize :artists

  before_validation :set_slug

  validates :init_player_slug, presence: true, uniqueness: true
  validates :guest_player_slug, presence: true, uniqueness: true

  def to_param
    init_player_slug
  end

  private

  def set_slug
    self.init_player_slug = random_string
    self.guest_player_slug = random_string
  end

  def random_string
    SecureRandom.urlsafe_base64(5)
  end
end
