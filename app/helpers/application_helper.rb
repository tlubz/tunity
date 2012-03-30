module ApplicationHelper
  def inline_jsonp(method, args)
    "<script type=\"text/javascript\">/*<![CDATA[*/#{method}(#{args.to_json});/*]]>*/</script>".html_safe
  end

  def js_page_vars
    @js_page_vars || {}
  end

  def js_config
    @js_config || {}
  end
end
