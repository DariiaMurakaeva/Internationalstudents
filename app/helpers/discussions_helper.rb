module DiscussionsHelper
  def tag_color_class(tag)
    return 'TagRed' if tag.nil?

    case tag.downcase
    when 'обучение' then 'TagGreen'
    when 'быт' then 'TagPink'
    when 'документы' then 'TagBlue'
    else 'TagRed'
    end
  end
end