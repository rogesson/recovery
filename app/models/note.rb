class Note < ActiveRecord::Base
  self.table_name = "notes"

  attr_accessible :title, :body

  validates :title, :body, presence: true

  belongs_to :user

  belongs_to :category

  before_save :encrypt_note

  def short_title
    return if self.title.size < 10

    self.title[0..9] + "..."
  end

  def formatted_title
    title.capitalize
  end

  def category_title
    category ? category.title : "Empty"
  end

  def formatted_created_At
    created_at.strftime("%d/%m/%Y")
  end

  def unsafe_body
    return if new_record?

    # Forçando c_key para testes de model.
    c_key =  session[:c_key] rescue 'a8f5f167f44f4964e6c998dee827110c'

    DigestManager.dec(self.body, c_key)      
  end

  private

  def encrypt_note
    # Forçando c_key para testes de model.
    c_key =  session[:c_key] rescue 'a8f5f167f44f4964e6c998dee827110c'

    self.body = DigestManager.enc(self.body, c_key)
  end
end
