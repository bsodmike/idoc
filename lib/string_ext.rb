class String
  def smart_pluralize(num=self)
    num.to_i.abs == 1 ? self : pluralize
  end
end
