# frozen_string_literal: true

module Jekyll
  class CodeFileBlock < Liquid::Block
    def initialize(_tag, file_name, _tokens)
      super
      @file_name = file_name
    end

    def render(context)
      text = super

      <<~HTML
        {::nomarkdown}
          <div class="code-file">
            <code class="code-file-name"> #{@file_name} </code>
        {:/}
            #{text}
        {::nomarkdown}
          </div>
        {:/}
      HTML
    end
  end
end

Liquid::Template.register_tag('codefile', Jekyll::CodeFileBlock)
