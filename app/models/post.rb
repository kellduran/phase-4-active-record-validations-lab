class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length:  { maximum: 250 }
    validates :category, inclusion: {
        in: ['Fiction', 'Non-Fiction']
      }
    # validate :title_is_clickbait

    # def title_is_clickbait(title)
    #     must_include= ["Won't Believe", "Secret", "Top \d", "Guess"]
    #     must_include.any?{|t| title.downcase.includes?(t.downcase)}
    #     if title.valid? 
    #         render json: post, status: :created
    #     else
    #         errors.add(:title, "Must include more clickbait-y words like Won't Believe, Secret, or Guess")
    #     end
    # end
    validate :clickbait?

    CLICKBAIT_PATTERNS = [
      /Won't Believe/i,
      /Secret/i,
      /Top \d/i,
      /Guess/i
    ]
  
    def clickbait?
      if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
        errors.add(:title, "must be clickbait")
      end
    end
end

