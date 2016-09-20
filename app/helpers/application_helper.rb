module ApplicationHelper
  def get_index page, per_page
    page = page.nil? ? 1 : page
    ((page.to_i - 1)*per_page.to_i)+1
  end
end
