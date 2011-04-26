module ApplicationHelper
  def title(page_title)
    @title = page_title
  end
  
  def show_title(sub_title)
    sub_title ? " | #{sub_title}" : ""
  end
  
  
end
