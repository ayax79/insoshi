module BlogsHelper
  def blog_tab_path(blog)
    person_path(blog.person, :anchor => "tBlog")
  end

  def blog_tab_url(blog)
    person_url(blog.person, :anchor => "tBlog")
  end

  def blog_editable?(blog)
    unless blog.artist.nil?
      blog.artist.member?(current_person)
    else
      current_person?(@blog.person)
    end
  end
end
