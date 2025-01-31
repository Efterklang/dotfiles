({
  // Please visit the URL below for more information:
  // https://shd101wyy.github.io/markdown-preview-enhanced/#/extend-parser

  onWillParseMarkdown: async function(markdown) {
    markdown = markdown.replace(
      /\{% endraw %}/g,
      (whole) =>  (``)
    )

    markdown = markdown.replace(
      /\{% raw %}/g,
      (whole) =>  (``)
    )
    return markdown;
  },

  onDidParseMarkdown: async function(html) {
    return html;
  },
  
})