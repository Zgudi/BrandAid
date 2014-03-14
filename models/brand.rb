# encoding: utf-8
class Brand
  include Mongoid::Document

  field :name, type: String
  field :name_usage, type: String

  field :logos, type: Hash
  field :logos_usage, type: String

  field :colors, type: Hash
  field :colors_usage, type: String

  field :taglines, type: Hash
  field :taglines_usage, type: String

  field :fonts, type: Hash

  field :person_id, type: String

  validates_presence_of [:name, :name_usage]
  validates_uniqueness_of :name
  validates :name, length: { minimum: 3 }
  validates :name_usage, length: { minimum: 10 }
  validate :validate_colors, :validate_taglines, :validate_fonts

  private

  def validate_colors
    unless colors_usage.nil?
      errors.add(:colors, "can't be blank, remove box or add color")  unless colors.present?
      errors.add(:colors_usage, "can't be blank")  unless colors_usage.present?
      errors.add(:colors_usage, "is too short (minimum is 10 characters)") if colors_usage.length < 10
      colors.each do |color|
        errors.add(:"colors_#{color[0]}", "is invalid") unless color[1].match(/^([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/)
      end if colors.present?
    end
  end

  def validate_taglines
    unless taglines_usage.nil?
      errors.add(:taglines, "can't be blank, remove box or add tagline")  unless taglines.present?
      errors.add(:taglines_usage, "can't be blank")  unless taglines_usage.present?
      errors.add(:taglines_usage, "is too short (minimum is 10 characters)") if taglines_usage.length < 10
      taglines.each do |tagline|
        errors.add(:"taglines_#{tagline[0]}", "minimum is 5 characters") if tagline[1].to_s.length < 5
      end if taglines.present?
    end
  end

  def validate_fonts
    unless fonts.nil?
      fonts.each do |group|
        errors.add(:"fonts_#{group[0]}", "can't be blank, remove box or add font") unless group[1]["font"].present?
        errors.add(:"fonts_#{group[0]}_purpose", "minimum is 5 characters") if group[1]["purpose"].to_s.length < 5
        errors.add(:"fonts_#{group[0]}_fonts_usage", "minimum is 5 characters") if group[1]["fonts_usage"].to_s.length < 5
        group[1]["font"].each do |font|
          errors.add(:"fonts_#{group[0]}_font_#{font[0]}", "minimum is 3 characters") if group[1]["font"][font[0]].to_s.length < 3
        end if group[1]["font"].present?
      end if fonts.present?
    end
  end
end