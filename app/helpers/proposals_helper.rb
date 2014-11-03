module ProposalsHelper
  def help_tooltip(text)
    content_tag :span, class: 'help-inline' do
      content_tag :fa, '', class: 'fa fa-exclamation-circle', title: text, data: {toggle: 'tooltip', placement: 'right'}
    end
  end
end
