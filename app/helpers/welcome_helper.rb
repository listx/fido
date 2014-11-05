module WelcomeHelper
  def truncate_paragraph(str, link_path)
    pars = str.split("\n\n")
    link = ""
    if pars.size > 1
      link = link_to("(read_more)", link_path)
    end
    [pars[0], link]
  end
end
