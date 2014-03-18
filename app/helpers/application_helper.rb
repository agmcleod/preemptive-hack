module ApplicationHelper
  def errors_out(object)
    content_tag 'div', id: 'error_explanation' do
      content_tag 'h2', "#{pluralize(object.errors.count, "error")} prohibited this #{object.class.model_name.singular.gsub('_', ' ')} from being saved:"
      content_tag 'ul' do
        object.errors.full_messages.collect do |msg|
          concat content_tag('li', msg)
        end
      end
    end
  end
end
