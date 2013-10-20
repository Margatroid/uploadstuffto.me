class EditMode
  setup: =>
    $('.tile').click(this.tileOnClick)
    $('.tile-select').change(this.tileSelectOnChange)

  onLoad: =>
    this.setup() if $('.leave-edit-mode').length

  # Make entire tile behave like the checkbox.
  tileOnClick: (event) =>
    $target = $(event.target)
    return if $target.hasClass('tile-select')
    event.preventDefault()

    if $target.hasClass('tile')
      checkbox = $target.find('.tile-select')
    else
      checkbox = $target.parents('.tile').find('.tile-select')

    checkbox.prop('checked', !checkbox.prop('checked'))
    checkbox.change()

  # Change colouring of entire tile when checkbox is ticked.
  tileSelectOnChange: (event) =>
    $tile = $(event.target).parent('.tile')
    if $(event.target).is(':checked')
      $tile.addClass('checked')
    else
      $tile.removeClass('checked')

this.EditMode = EditMode