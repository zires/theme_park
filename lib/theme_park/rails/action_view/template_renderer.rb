# encoding: utf-8
class ActionView::TemplateRenderer

  alias_method :_render_template_original, :render_template

  def render_and_assign_template(template, layout_name = nil, locals = {})
    @view.controller.current_template = template.identifier
    _render_template_original(template, layout_name, locals)
  end

  alias_method :render_template, :render_and_assign_template

end