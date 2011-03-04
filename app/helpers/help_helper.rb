module HelpHelper
  def faq(q, a)
    # generate html code for an FAQ question and expandable answer
    html += '<a class="question" href="#">' + q + '?</a>'
    html += '<p>' + a + '</p>'
    html.html_safe
  end
end
