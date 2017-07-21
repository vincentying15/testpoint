module PageHelper
  def new_button(model, url, options = {})
    label = t("views.action.new", model_name: h(model))
    link_to label, url, { class: "btn btn-primary" }.merge(options)
  end

  def edit_link(url, options = {})
    label = t("views.action.edit")
    link_to label, url, options
  end

  def show_link(url, options = {})
    label = t("views.action.show")
    link_to label, url, options
  end

  def back_link(url, options = {})
    label = t("views.action.back")
    link_to label, url, options
  end

  def task_state_text(task)
    class_name = case task.state
                 when "pass"
                   "text-success"
                 when "failure"
                   "text-danger"
                 end

    content_tag :span, task.state_text, class: class_name
  end
end