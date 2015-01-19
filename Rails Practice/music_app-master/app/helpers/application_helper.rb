module ApplicationHelper
  def add_auth_token
    <<-HTML.html_safe
      <pre><input type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}"></pre>
    HTML
  end

  def display_errors(object)
    <<-HTML.html_safe
      <pre>#{h(object.errors.full_messages.join("\n"))}</pre>
    HTML
  end
end
