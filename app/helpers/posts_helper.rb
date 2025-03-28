module PostsHelper
  def card_color_class(tag)
    return 'Card_Red' if tag.nil?

    case tag.downcase
    when 'обучение' then 'Card_Green'
    when 'быт' then 'Card_Pink'
    when 'документы' then 'Card_Blue'
    else 'Card_Red'
    end
  end
  
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
