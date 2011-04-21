module HelpHelper
  # Generate html code for an FAQ question and expandable answer
  def faq(q, a)
    html = '<a class="question" href="#">' + q + '?</a>'
    html += '<p class="answer">' + a + '</p>'
    html.html_safe
  end

  # Generate html code for a screenshot
  def screenshot(num)
    path = "/images/screenshots/#{num}.png"
    "<a href='#{path}' class='screenshot'><img src='#{path}' alt='Screenshot' /></a>".html_safe
  end
end
