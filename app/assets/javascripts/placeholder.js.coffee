# Internet Explorer 9 and other older browsers do not support
# HTML5 placeholders. Labels are rendered by default then hidden by
# JavaScript if the feature is detected. This way we can still have
# labels describing each input should the browser not support placeholders
# and have JavaScript disabled.
class PlaceholderCompatibility
  onLoad: =>
    this.removeLabels() if (this.supportsPlaceholder())

  removeLabels: =>
    $('label').each (index, label) =>
      unless $(label).prev('input[type="checkbox"]').length
        $(label).next('br').remove()
        $(label).remove()

  supportsPlaceholder: =>
    return ('placeholder' of document.createElement('input'))

this.PlaceholderCompatibility = PlaceholderCompatibility