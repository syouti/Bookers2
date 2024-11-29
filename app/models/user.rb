class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy  # この行を追加

  # app/models/user.rb
# app/models/user.rb
def get_profile_image(width, height)
  # デフォルト画像のパスを設定
  default_image_path = Rails.root.join('app/assets/images/no-image.jpg')

  unless profile_image.attached?
    begin
      # デフォルト画像を添付
      profile_image.attach(
        io: File.open(default_image_path),
        filename: 'default-image.jpg',
        content_type: 'image/jpeg'
      )
    rescue => e
      # 添付に失敗した場合はデフォルト画像のパスを返す
      Rails.logger.error "Failed to attach default image: #{e.message}"
      return 'no-image.jpg'
    end
  end

  begin
    # 画像のリサイズを試みる
    profile_image.variant(resize_to_limit: [width, height]).processed
  rescue => e
    # リサイズに失敗した場合もデフォルト画像のパスを返す
    Rails.logger.error "Failed to process image: #{e.message}"
    'no-image.jpg'
  end
end

validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
validates :introduction, length: { maximum: 50 }
end
