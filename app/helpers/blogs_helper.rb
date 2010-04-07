module BlogsHelper
  def blog_tab_path(blog)
    unless blog.artist.nil?
      artist_path(blog.artist, :anchor => "tBlog")
    else
      person_path(blog.person, :anchor => "tBlog")
    end
  end

  def blog_tab_url(blog)
    unless blog.artist.nil?
      artist_path(blog.artist, :anchor => "tBlog")
    else
      person_url(blog.person, :anchor => "tBlog")
    end
  end

  def blog_editable?(blog)
    unless blog.artist.nil?
      blog.artist.member?(current_person)
    else
      current_person?(@blog.person)
    end
  end
end
