module CssInfoHelper

  def getCSSInfo()
    _css = `cat app/assets/stylesheets/_variables.css.scss`.split("\n")
    _css_vars = {}
    _css.each do |_line|
      if _line =~ /\:/
        _var_name = _line.split(":")[0].gsub(/^\$/, "").strip()
        _var_value = _line.split(":")[1].gsub(/\;$/, "").strip()
        _css_vars[_var_name] = _var_value
      end
    end
    return _css_vars
  end

end
