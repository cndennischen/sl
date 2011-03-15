module HelpHelper
  def faq(q, a)
    # generate html code for an FAQ question and expandable answer
    html = '<a class="question" href="#">' + q + '?</a>'
    html += '<p class="answer">' + a + '</p>'
    html.html_safe
  end
  
  def screenshot(num)
    # generates html code for a screenshot
    path = "/images/screenshots/#{num}.png"
    "<a href='#{path}' class='screenshot'><img src='#{path}' alt='Screenshot' /></a>".html_safe
  end
end
